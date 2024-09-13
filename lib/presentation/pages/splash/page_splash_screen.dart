import 'dart:async';

import 'package:flutter/material.dart';
class SplashScreenPage extends StatefulWidget {
  final String dest;

  const SplashScreenPage({
    super.key,
    required this.dest,
  });

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(seconds: 1), () {
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
