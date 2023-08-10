import 'dummy/dummy_service.dart'
if (dart.library.html)'web/web_service.dart'
if (dart.library.io)'mobile/mobile_service.dart';

abstract class PlatformService {
  Future<String> getValue(String arg);

  Stream<String> getStream(String arg);

  void toStream(String arg);
}

PlatformService getService() {
  return PlatformServiceImpl();
}