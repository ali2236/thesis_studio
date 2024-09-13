import 'package:flutter/material.dart';
import 'package:thesis_studio/presentation/navigation/route_builder.dart';

extension NavigationUtils on BuildContext {
  void push(WidgetBuilder builder){
    final route = RouteBuilder.route(builder);
    Navigator.of(this).push(route);
  }

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}