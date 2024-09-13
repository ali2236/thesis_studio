import '../model/model.dart';

abstract class Repository<M extends Model, ID, Filter> {
  Future<void> update(ID id, M? model); // create - update - delete
  Future<void> add(M model);
  Stream<M> get(ID id);
  Stream<List<M>> getAll(Filter? filter);

  const Repository();
}
