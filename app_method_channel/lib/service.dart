
import 'dart:developer' as dev;

import 'package:flutter/services.dart';

class PlatformService{
  static const method = MethodChannel('CALL_METHOD');
  static const stream = EventChannel('CALL_EVENTS');

  Future<String> callMethodChannel(String arg) async {
    try{
      return await method.invokeMethod('CALL', arg);
    } on PlatformException catch (e){
      dev.log('Failed to get value: ${e.message}');
      throw('$e');
    }
  }

  Stream<String> callEventChanel(String arg) => stream.receiveBroadcastStream()
      .map((event) {
        print(event);
        return event as String;
      });
}


