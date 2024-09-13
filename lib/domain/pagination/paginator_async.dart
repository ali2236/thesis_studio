import 'package:thesis_studio/data/model/model.dart';
import 'package:thesis_studio/data/model/pagination.dart';
import 'package:thesis_studio/data/model/paginator.dart';

class AsyncPaginator<M extends Model> extends Paginator<M>{

  final Future<Pagination<M>> Function(int page) fetchPage;

  const AsyncPaginator({required this.fetchPage});

  @override
  Future<Pagination<M>> getPage(int page) {
    return fetchPage(page);
  }

}