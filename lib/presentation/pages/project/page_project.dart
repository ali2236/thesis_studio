import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:path/path.dart' as p;
import 'package:pdfrx/pdfrx.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/latex.dart';
import 'package:re_highlight/styles/atom-one-light.dart';
import 'package:thesis_studio/domain/editor/thesis_editor.dart';
import 'package:thesis_studio/domain/model/model_project.dart';
import 'package:thesis_studio/presentation/entities/filesystem/file_list_tile.dart';
import 'package:thesis_studio/presentation/widgets/window/sidebar/side_bar_button.dart';
import 'package:thesis_studio/presentation/widgets/window/sidebar/window_side_bar.dart';
import 'package:thesis_studio/presentation/widgets/window/topbar/top_bar_menu_button.dart';
import 'package:thesis_studio/presentation/widgets/window/topbar/window_top_bar.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  const ProjectPage({
    super.key,
    required this.project,
  });

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  late ThesisEditor editor;
  final pdfController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    editor = ThesisEditor(widget.project);
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return Scaffold(
      appBar: WindowTopBar(
        actions: [
          TopBarMenuButton(
            label: 'File',
            menu: [
              MenuItem(
                icon: Icons.exit_to_app,
                label: 'Close Project',
                onSelected: () => nav.pop(),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          const WindowSideBar(
            children: [
              SideBarButton(
                icon: Icon(Icons.folder),
                label: 'Files',
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          SizedBox(
            width: 200,
            child: StreamBuilder<String?>(
                stream: editor.watchOpenFile(),
                builder: (context, snapshot) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomScrollView(
                      slivers: [
                        TreeSliver<FileSystemEntity>(
                          treeRowExtentBuilder: (node, dim) => 24,
                          tree: Directory.fromUri(widget.project.path)
                              .listSync()
                              .map((f) => TreeSliverNode(f))
                              .toList(),
                          treeNodeBuilder: (context, node, animation) {
                            final file = node.content as FileSystemEntity;
                            return FileListTile(
                              file: file,
                              selected:
                                  snapshot.data == p.canonicalize(file.path),
                              onTap: () {
                                if (file is File) {
                                  editor.openFile(file.path);
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: StreamBuilder(
                stream: editor.watchOpenFile(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    try {
                      final txtFile = snapshot.requireData!;
                      final content = File(txtFile).readAsStringSync();
                      final controller =
                      CodeLineEditingController.fromText(content);
                      return CodeEditor(
                        controller: controller,
                        style: CodeEditorStyle(
                          fontFamily: 'vazirmtn',
                          fontSize: 14,
                          codeTheme: CodeHighlightTheme(
                            languages: {
                              'latex': CodeHighlightThemeMode(mode: langLatex)
                            },
                            theme: atomOneLightTheme,
                          ),
                        ),
                        shortcutOverrideActions: {
                          CodeShortcutSaveIntent: CallbackAction(
                            onInvoke: (Intent intent) {
                              editor.save(controller.text);
                              return null;
                            },
                          ),
                        },
                      );
                    } catch (e) {}
                  }
                  return Container();
                }),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                devicePixelRatio: MediaQuery.of(context).devicePixelRatio * 2,
              ),
              child: StreamBuilder(
                stream: editor.watchOpenFile(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final file = snapshot.requireData!;
                    final directory = p.dirname(file);
                    final fileName = '${p.basenameWithoutExtension(file)}.pdf';
                    final pdfPath = p.join(directory, fileName);
                    return StreamBuilder(
                        stream: editor.watchOutput(),
                        builder: (context, snapshot) {
                          return PdfViewer(
                            VersionedPdfDocument(pdfPath, snapshot.data ?? 1),
                            controller: pdfController,
                            params: PdfViewerParams(
                              margin: 0.0,
                              getPageRenderingScale:
                                  (context, page, controller, estimatedScale) {
                                return 400 / 72;
                              },
                            ),
                          );
                        });
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VersionedPdfDocument extends PdfDocumentRefFile {
  final int version;

  const VersionedPdfDocument(super.file, this.version);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is VersionedPdfDocument &&
          runtimeType == other.runtimeType &&
          version == other.version;

  @override
  int get hashCode => super.hashCode ^ version.hashCode;
}
