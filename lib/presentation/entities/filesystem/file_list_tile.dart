import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class FileListTile extends StatelessWidget {
  final FileSystemEntity file;
  final VoidCallback onTap;
  final bool selected;

  const FileListTile({
    super.key,
    required this.file, required this.onTap, this.selected = false,
  });

  Widget fileIcon() {
    const iconSize = 16.0;
    switch (file) {
      case Directory():
        return const Icon(Icons.folder, size: iconSize);
      case Link():
        return const Icon(CommunityMaterialIcons.file_link, size: iconSize);
      default:
        return const Icon(CommunityMaterialIcons.file, size: iconSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = p.basename(file.path);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          fileIcon(),
          const SizedBox(width: 4),
          Text(fileName, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
