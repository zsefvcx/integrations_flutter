
import 'package:app_ffi_cpp/platform/mobile_service.dart';

abstract class PlatformService {
  Future<String> getValue(String arg);

  // Stream<String> getStream(String arg);
  //
  // void toStream(String arg);
}

PlatformService getService() {
  return PlatformServiceImpl();
}