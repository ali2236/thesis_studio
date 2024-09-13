import 'package:flutter/cupertino.dart';
import 'package:thesis_studio/presentation/navigation/simple_route_builder.dart';

class RouteBuilder {
  static PageRoute<T> route<T>(WidgetBuilder builder){
    return SimpleRouteBuilder(builder: builder);
  }
}