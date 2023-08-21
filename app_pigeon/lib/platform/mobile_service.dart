
import 'dart:developer' as dev;

import 'package:app_pigeon/platform/service.dart';
import 'package:app_pigeon/src/data_controller.dart';
import 'package:app_pigeon/src/sender_data.g.dart';


class PlatformServiceImpl implements PlatformService{

  @override
  Future<String> getValue(String arg) async {
    try{
      dev.log(arg);
      SendData data = SendData(data: arg);
      await DataController.instance().send(data);
      //Скорее всего надо будет ожидать сообщение, но не факт
      return DataController.instance().rcv.data??'null';

    } catch (e){
      dev.log('Failed to get value: $e');
      throw('$e');
    }
  }


  @override
  void toStream(String arg) {
    // TODO: implement toStream
  }

  @override
  Stream<String> getStream(String arg) {
    // TODO: implement getStream
    throw UnimplementedError();
  }
}


