
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformViewMobile extends StatelessWidget {
  const PlatformViewMobile({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    late final Widget view;

    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{
      '0': data
    };

    if(defaultTargetPlatform == TargetPlatform.android){
      view = AndroidView(viewType: 'INTEGRATION_ANDROID',
          onPlatformViewCreated: (id){
            dev.log('Android PlatformView with id:$id created');
          },
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
      return view;
    }


    return const Placeholder();
  }
}
