import 'package:json_annotation/json_annotation.dart';
import 'package:thesis_studio/data/data_layer.dart';

class ModelConverter<M extends Model>
    extends JsonConverter<M, Map<String, dynamic>> {
  const ModelConverter();

  @override
  M fromJson(Map<String, dynamic>? json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(M object) {
    throw UnimplementedError();
    //return object.toJson();
  }
}
