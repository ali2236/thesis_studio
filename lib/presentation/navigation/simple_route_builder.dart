
import 'package:flutter/material.dart';

class SimpleRouteBuilder<T> extends MaterialPageRoute<T> {
  SimpleRouteBuilder({required super.builder});

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}