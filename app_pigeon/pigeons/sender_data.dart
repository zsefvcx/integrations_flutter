// BLA BLA BLA....

import 'package:pigeon/pigeon.dart';

//dart run pigeon --input pigeons/sender_data.dart

// #docregion config
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/sender_data.g.dart',
  dartOptions: DartOptions(),
  cppOptions: CppOptions(namespace: 'pigeon_sender_data'),
  cppHeaderOut: 'windows/runner/sender_data.g.h',
  cppSourceOut: 'windows/runner/sender_data.g.cpp',
  kotlinOut:
  'android/app/src/main/kotlin/dev/flutter/pigeon_example_app/SenderData.g.kt',
  kotlinOptions: KotlinOptions(),
  javaOut: 'android/app/src/main/java/io/flutter/plugins/SenderData.java',
  javaOptions: JavaOptions(),
  swiftOut: 'ios/Runner/SenderData.g.swift',
  swiftOptions: SwiftOptions(),
  objcHeaderOut: 'macos/Runner/sender_data.g.h',
  objcSourceOut: 'macos/Runner/sender_data.g.m',
  // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
  objcOptions: ObjcOptions(prefix: 'PGN'),
  copyrightHeader: 'pigeons/copyright.txt',
  dartPackageName: 'pigeon_sender_data',
))
// #enddocregion config

class SendData {
  String? data;
}

class SenderStatus{
  bool? resultSuccessful;
  bool? hasError;
  String? error;
}

class ReceiveData {
  String? data;
}

@HostApi()
abstract class DataSender{
  SenderStatus send(SendData data);
}

@FlutterApi()
abstract class DataReceiver{
  void receive(ReceiveData data);
}