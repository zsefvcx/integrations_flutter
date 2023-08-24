
import 'dart:developer' as dev;

import 'package:app_flutter_module/platform/service.dart';
import 'package:flutter/services.dart';

class PlatformServiceImpl implements PlatformService{
  static const method = MethodChannel('CALL_METHOD');

  @override
  Future<int> getValue() async {
    try{
      return await method.invokeMethod('CALL');
    } on PlatformException catch (e){
      dev.log('Failed to get value: ${e.message}');
      throw('$e');
    }
  }
}


