import 'package:thesis_studio/data/data_layer.dart';
import 'package:thesis_studio/data/repository/repository.dart';

abstract class DataRepository<M extends Model, ID, Filter>
    extends Repository<M, ID, Filter> {
  final DataSource<M, ID> dataSource;

  const DataRepository(this.dataSource);

  @override
  Stream<M> get(ID id) {
    return dataSource.get(id);
  }

  @override
  Stream<List<M>> getAll(void filter) {
    return dataSource.getAll();
  }

  @override
  Future<void> update(ID id, M? model) {
    if (model == null) {
      return dataSource.delete(id);
    } else {
      return dataSource.update(model);
    }
  }

  @override
  Future<void> add(M model) {
    return dataSource.create(model);
  }
}
