import 'dart:collection';

import '../data_layer.dart';

class MemoryDataSource<M extends Model, ID> extends DataSource<M, ID> {

  final _data = <M>[];

  @override
  Future<void> create(M model) async {
    _data.add(model);
  }

  @override
  Future<void> delete(ID id) async {
    _data.removeWhere((it)=>it.uniqueKey == id);
  }

  @override
  Stream<M> get(ID id) {
    final d = _data.firstWhere((it) => it.uniqueKey == id);
    return Stream.value(d);
  }

  @override
  Future<void> update(M model) async {
    _data.removeWhere((it) => it.uniqueKey == model.uniqueKey);
    _data.add(model);
  }

  @override
  Stream<List<M>> getAll() {
    return Stream.value(UnmodifiableListView(_data));
  }

}