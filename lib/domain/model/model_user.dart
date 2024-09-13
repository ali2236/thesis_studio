import 'package:json_annotation/json_annotation.dart';
import 'package:thesis_studio/common/types.dart';
import 'package:thesis_studio/data/data_layer.dart';

part 'model_user.g.dart';

@JsonSerializable()
class User implements Model<int>{
  final int userId;
  final String username;

  const User({
    required this.userId,
    required this.username,
  });

  static const fromJson = _$UserFromJson;

  @override
  int get uniqueKey => userId;

  @override
  JSON toJson() => _$UserToJson(this);
}
