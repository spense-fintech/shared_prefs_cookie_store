import 'package:flutter_test/flutter_test.dart';
import 'package:shared_prefs_cookie_store/shared_prefs_cookie_store.dart';
import 'package:shared_prefs_cookie_store/shared_prefs_cookie_store_platform_interface.dart';
import 'package:shared_prefs_cookie_store/shared_prefs_cookie_store_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSharedPrefsCookieStorePlatform
    with MockPlatformInterfaceMixin
    implements SharedPrefsCookieStorePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SharedPrefsCookieStorePlatform initialPlatform = SharedPrefsCookieStorePlatform.instance;

  test('$MethodChannelSharedPrefsCookieStore is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSharedPrefsCookieStore>());
  });

  test('getPlatformVersion', () async {
    SharedPrefsCookieStore sharedPrefsCookieStorePlugin = SharedPrefsCookieStore();
    MockSharedPrefsCookieStorePlatform fakePlatform = MockSharedPrefsCookieStorePlatform();
    SharedPrefsCookieStorePlatform.instance = fakePlatform;

    expect(await sharedPrefsCookieStorePlugin.getPlatformVersion(), '42');
  });
}
