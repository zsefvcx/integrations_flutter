
import 'dart:developer' as dev;

import 'package:app_ffi_cpp/ffi_bridge.dart';
import 'package:app_ffi_cpp/platform/service.dart';

class PlatformServiceImpl implements PlatformService{

  final _bridge = FFIBridge();

  @override
  Future<String> getValue(String arg) async {
    try{
      dev.log(arg);
      return _bridge.getCValue(arg).toString();

    } catch (e){
      dev.log('Failed to get value: $e');
      throw('$e');
    }
  }


  // @override
  // void toStream(String arg) {
  //   // TODO: implement toStream
  // }
  //
  // @override
  // Stream<String> getStream(String arg) {
  //   // TODO: implement getStream
  //   throw UnimplementedError();
  //}
}


