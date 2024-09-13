import 'package:sembast/sembast.dart';
import 'package:thesis_studio/common/types.dart';
import 'package:thesis_studio/data/data_layer.dart';

class SembastDataSource<M extends Model, ID> extends DataSource<M, ID> {
  final Database db;
  final StoreRef<dynamic, JSON> _ref;
  final M Function(JSON json) fromJson;

  SembastDataSource({
    required this.db,
    required String modelName,
    required this.fromJson,
  }) : _ref = StoreRef(modelName);

  @override
  Future<void> create(M model) {
    return _ref.add(db, _toJson(model));
  }

  @override
  Future<void> delete(ID id) {
    return _ref.delete(db, finder: _find(id));
  }

  @override
  Stream<M> get(ID id) async* {
    final record = await _ref.findFirst(db, finder: _find(id));
    if (record?.value == null) {
      yield* const Stream.empty();
      return;
    }
    // first value
    yield fromJson(record!.value);

    // next values
    await for (var snapshot in record.ref.onSnapshot(db)) {
      if (snapshot?.value != null) {
        yield fromJson(snapshot!.value);
      } else {
        yield* const Stream.empty();
      }
    }
  }

  @override
  Stream<List<M>> getAll() {
    return _ref.query().onSnapshots(db).map<List<M>>(
        (List<RecordSnapshot<dynamic, JSON>> records) => records
            .map<M>((RecordSnapshot<dynamic, JSON> snapshot) =>
                fromJson(snapshot.value))
            .toList());
  }

  @override
  Future<void> update(M model) {
    return _ref.update(db, _toJson(model), finder: _find(model.uniqueKey));
  }

  JSON _toJson(M model) {
    return {
      '_id': model.uniqueKey,
      ...model.toJson(),
    };
  }

  Finder _find(ID id) {
    return Finder(filter: Filter.equals('_id', id), limit: 1);
  }
}
