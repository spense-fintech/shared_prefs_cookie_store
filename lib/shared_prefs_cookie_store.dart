import 'package:cookie_jar/cookie_jar.dart';
import 'shared_pref_storage.dart';

class SharedPrefCookieStore extends PersistCookieJar {
  SharedPrefCookieStore({
    bool persistSession = true,
    bool ignoreExpires = false,
    bool deleteHostCookiesWhenLoadFailed = true,
  }) : super(
    ignoreExpires: ignoreExpires,
    storage: SharedPrefStorage(),
    persistSession: persistSession,
    deleteHostCookiesWhenLoadFailed: deleteHostCookiesWhenLoadFailed,
  );
}