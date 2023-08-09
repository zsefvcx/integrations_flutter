

import 'package:app_method_channel/platform/service.dart';

import 'web_interop.dart';

class PlatformServiceImpl implements PlatformService{
  final _manager = InteropManager();

  @override
  Stream<String> getStream(String arg) {
    return _manager.buttonClicked(arg);
  }

  @override
  Future<String> getValue(String arg) async {
    return _manager.getValueFromJs(arg);
  }
}