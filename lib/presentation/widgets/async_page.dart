import 'package:flutter/material.dart';

class AsyncPage<T> extends StatelessWidget {
  final T? initial;
  final Future<T> future;
  final Widget Function(T data) builder;

  const AsyncPage({
    super.key,
    this.initial,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.requireData);
        }
        return Container();
      },
    );
  }
}
