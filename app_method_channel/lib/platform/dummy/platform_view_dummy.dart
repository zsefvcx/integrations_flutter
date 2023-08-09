import 'package:flutter/material.dart';

class PlatformView extends StatelessWidget {
  const PlatformView({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 20,
        width: 200,
        child: Text('Platform in not supported'));
  }
}
