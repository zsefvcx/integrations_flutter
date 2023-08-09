import 'dart:developer' as dev;

import 'package:flutter/material.dart';

class PlatformView extends StatelessWidget {
  const PlatformView({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 200,
        child: HtmlElementView(
          viewType: 'web-button',
           onPlatformViewCreated: (id){
              dev.log('Web PlatformView with id:$id created');
            }
        ),


    );
  }
}