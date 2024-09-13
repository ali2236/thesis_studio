
import 'model.dart';

class Pagination<M extends Model> {
  final List<M> data;
  final bool hasNextPage;

  const Pagination({
    required this.data,
    required this.hasNextPage,
  });

  const Pagination.last(this.data) : hasNextPage = false;
}
