// //BLA BLA BLA....
// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class SendData {
  SendData({
    this.data,
  });

  String? data;

  Object encode() {
    return <Object?>[
      data,
    ];
  }

  static SendData decode(Object result) {
    result as List<Object?>;
    return SendData(
      data: result[0] as String?,
    );
  }
}

class SenderStatus {
  SenderStatus({
    this.resultSuccessful,
    this.hasError,
    this.error,
  });

  bool? resultSuccessful;

  bool? hasError;

  String? error;

  Object encode() {
    return <Object?>[
      resultSuccessful,
      hasError,
      error,
    ];
  }

  static SenderStatus decode(Object result) {
    result as List<Object?>;
    return SenderStatus(
      resultSuccessful: result[0] as bool?,
      hasError: result[1] as bool?,
      error: result[2] as String?,
    );
  }
}

class ReceiveData {
  ReceiveData({
    this.data,
  });

  String? data;

  Object encode() {
    return <Object?>[
      data,
    ];
  }

  static ReceiveData decode(Object result) {
    result as List<Object?>;
    return ReceiveData(
      data: result[0] as String?,
    );
  }
}

class _DataSenderCodec extends StandardMessageCodec {
  const _DataSenderCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is SendData) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is SenderStatus) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return SendData.decode(readValue(buffer)!);
      case 129: 
        return SenderStatus.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class DataSender {
  /// Constructor for [DataSender].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  DataSender({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _DataSenderCodec();

  Future<SenderStatus> send(SendData arg_data) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.pigeon_sender_data.DataSender.send', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_data]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as SenderStatus?)!;
    }
  }
}

class _DataReceiverCodec extends StandardMessageCodec {
  const _DataReceiverCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ReceiveData) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return ReceiveData.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class DataReceiver {
  static const MessageCodec<Object?> codec = _DataReceiverCodec();

  void receive(ReceiveData data);

  static void setup(DataReceiver? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.pigeon_sender_data.DataReceiver.receive', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.pigeon_sender_data.DataReceiver.receive was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final ReceiveData? arg_data = (args[0] as ReceiveData?);
          assert(arg_data != null,
              'Argument for dev.flutter.pigeon.pigeon_sender_data.DataReceiver.receive was null, expected non-null ReceiveData.');
          api.receive(arg_data!);
          return;
        });
      }
    }
  }
}