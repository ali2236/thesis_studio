

import 'model.dart';
import 'pagination.dart';

abstract class Paginator<M extends Model>{

  Future<Pagination<M>> getPage(int page);

  const Paginator();
}