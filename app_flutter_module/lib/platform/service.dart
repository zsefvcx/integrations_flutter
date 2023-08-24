import 'dummy/dummy_service.dart'
if (dart.library.io)'mobile/mobile_service.dart';

abstract class PlatformService {
  Future<int> getValue();
}

PlatformService getService() {
  return PlatformServiceImpl();
}