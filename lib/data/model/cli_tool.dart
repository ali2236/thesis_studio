import 'package:json_annotation/json_annotation.dart';
import 'package:thesis_studio/common/types.dart';
import 'package:thesis_studio/data/data_layer.dart';

part 'cli_tool.g.dart';

@JsonSerializable()
class CliTool extends Model<String> {
  final String name;
  final String command;

  const CliTool({required this.name, required this.command});

  @override
  String get uniqueKey => name;

  @override
  JSON toJson() => _$CliToolToJson(this);
}
