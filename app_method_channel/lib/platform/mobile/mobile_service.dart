
import 'dart:developer' as dev;

import 'package:app_method_channel/platform/service.dart';
import 'package:flutter/services.dart';

class PlatformServiceImpl implements PlatformService{
  static const method = MethodChannel('CALL_METHOD');
  static const stream = EventChannel('CALL_EVENTS');

  @override
  Future<String> getValue(String arg) async {
    try{
      dev.log(arg);
      return await method.invokeMethod('CALL', arg);
    } on PlatformException catch (e){
      dev.log('Failed to get value: ${e.message}');
      throw('$e');
    }
  }

  @override
  Stream<String> getStream(String arg) {
    return stream.receiveBroadcastStream(arg)
        .map((event) {
      dev.log(event);
      return event as String;
    });
  }

  @override
  void toStream(String arg) {
    // TODO: implement toStream
  }
}


