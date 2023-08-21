import 'dart:developer' as dev;

import 'package:app_pigeon/src/sender_data.g.dart';
import 'package:flutter/cupertino.dart';

abstract class IDataController {

  Future<SenderStatus> send(SendData data);

  @protected
  void receive(ReceiveData data);
}

class DataController implements IDataController, DataReceiver {
  static DataController? _instance;

  ReceiveData rcv = ReceiveData(data: 'null');

  factory DataController.instance() => _instance ??= DataController._();

  DataController._() : _sink = DataSender(){
    DataReceiver.setup(this);
  }

  DataSender _sink;

  @override
  void receive(ReceiveData data) {
    dev.log('message ${data.data}');
    rcv = data;
  }

  @override
  Future<SenderStatus> send(SendData data) =>
    _sink.send(data);



}


