import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'shared_prefs_cookie_store_platform_interface.dart';

/// An implementation of [SharedPrefsCookieStorePlatform] that uses method channels.
class MethodChannelSharedPrefsCookieStore extends SharedPrefsCookieStorePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('shared_prefs_cookie_store');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
