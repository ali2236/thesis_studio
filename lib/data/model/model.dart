import 'package:thesis_studio/common/types.dart';

abstract class Model<K>{
  const Model();

  K get uniqueKey;

  JSON toJson();
}