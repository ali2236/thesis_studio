// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      projectId: json['projectId'] as String,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      name: json['name'] as String,
      path: Uri.parse(json['path'] as String),
      lastOpen: json['lastOpen'] == null
          ? null
          : DateTime.parse(json['lastOpen'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'projectId': instance.projectId,
      'user': instance.user,
      'name': instance.name,
      'path': instance.path.toString(),
      'lastOpen': instance.lastOpen?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
