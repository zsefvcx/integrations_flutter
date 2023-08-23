
import 'dart:ffi' as ffi;
import 'dart:io' show Platform;

import 'package:ffi/ffi.dart';

typedef SimpleFunction = ffi.Int16 Function(ffi.Pointer<Utf8> arg);
typedef SimpleFunctionDart = int Function(ffi.Pointer<Utf8> arg);

const String _libName = 'stringlen';

class FFIBridge {
  late SimpleFunctionDart _getCValue;

  FFIBridge(){
    final dl = Platform.isAndroid ? ffi.DynamicLibrary.open('lib$_libName.so') : ffi.DynamicLibrary.process();
    _getCValue = dl.lookupFunction<SimpleFunction, SimpleFunctionDart>('get_len');
  }
  
  int getCValue(String arg) => _getCValue(arg.toNativeUtf8());
}