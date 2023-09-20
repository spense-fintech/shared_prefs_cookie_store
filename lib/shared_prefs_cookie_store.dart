
import 'shared_prefs_cookie_store_platform_interface.dart';

class SharedPrefsCookieStore {
  Future<String?> getPlatformVersion() {
    return SharedPrefsCookieStorePlatform.instance.getPlatformVersion();
  }
}
