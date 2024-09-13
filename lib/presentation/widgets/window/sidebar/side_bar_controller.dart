import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SideBarController<T>{
  final _selected = BehaviorSubject<T?>();

  static SideBarController<T> of<T>(BuildContext context){
    final SideBarControllerProvider<T>? result =
    context.dependOnInheritedWidgetOfExactType<SideBarControllerProvider<T>>();
    assert(result != null, 'No SideBarControllerProvider found in context');
    return result!.data;
  }

  void select(T? selection){
    _selected.add(selection);
  }

  Stream<T?> get selected => _selected.stream;

}

class SideBarControllerProvider<T> extends InheritedWidget {
  final SideBarController<T> data;
  const SideBarControllerProvider({
    super.key,
    required super.child,
    required this.data,
  });

  @override
  bool updateShouldNotify(SideBarControllerProvider oldWidget) {
    return oldWidget.data != data;
  }
}
