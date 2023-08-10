

import 'package:app_method_channel/platform/service.dart';

import 'web_interop.dart';

class PlatformServiceImpl implements PlatformService{
  final _manager = InteropManager();

  @override
  Stream<String> getStream(String arg) {
    //throw UnimplementedError();
    return _manager.getStreamEvent(arg);
  }

  @override
  Future<String> getValue(String arg) async {
    //throw UnimplementedError();
    return _manager.getValueFromJs(arg);
  }

  @override
  void toStream(String arg) {
    _manager.toStream(arg);
  }
}