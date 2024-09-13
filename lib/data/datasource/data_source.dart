import '../data_layer.dart';

abstract class DataSource<M extends Model, ID> {
  Future<void> create(M model);
  Future<void> delete(ID id);
  Future<void> update(M model);
  Stream<M> get(ID id);
  Stream<List<M>> getAll();

  const DataSource();
}