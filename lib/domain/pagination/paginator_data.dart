import 'package:thesis_studio/data/data_layer.dart';
import 'package:thesis_studio/data/model/pagination.dart';
import 'package:thesis_studio/data/model/paginator.dart';

class DataPaginator<M extends Model> extends Paginator<M> {
  final List<Pagination<M>> pages;

  DataPaginator({
    required this.pages,
  });

  @override
  Future<Pagination<M>> getPage(int page) async {
    return pages[page];
  }
}
