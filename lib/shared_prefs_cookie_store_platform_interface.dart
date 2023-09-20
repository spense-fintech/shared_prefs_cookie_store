import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'shared_prefs_cookie_store_method_channel.dart';

abstract class SharedPrefsCookieStorePlatform extends PlatformInterface {
  /// Constructs a SharedPrefsCookieStorePlatform.
  SharedPrefsCookieStorePlatform() : super(token: _token);

  static final Object _token = Object();

  static SharedPrefsCookieStorePlatform _instance = MethodChannelSharedPrefsCookieStore();

  /// The default instance of [SharedPrefsCookieStorePlatform] to use.
  ///
  /// Defaults to [MethodChannelSharedPrefsCookieStore].
  static SharedPrefsCookieStorePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SharedPrefsCookieStorePlatform] when
  /// they register themselves.
  static set instance(SharedPrefsCookieStorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
