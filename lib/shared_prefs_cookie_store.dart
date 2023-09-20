import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsCookieStore implements CookieJar {
  SharedPrefsCookieStore([this._prefs, this.ignoreExpires = false]);

  final Future<SharedPreferences>? _prefs;
  @override
  final bool ignoreExpires;

  Future<SharedPreferences> _getPrefs() async {
    return _prefs ?? SharedPreferences.getInstance();
  }

  @override
  Future<List<Cookie>> loadForRequest(Uri uri) async {
    final SharedPreferences prefs = await _getPrefs();
    return (prefs.getStringList(_getCookieKey(uri)) ?? [])
        .map((cookie) => Cookie.fromSetCookieValue(cookie))
        .toList();
  }

  @override
  Future<void> saveFromResponse(Uri uri, List<Cookie> newCookies) async {
    final SharedPreferences prefs = await _getPrefs();
    var existingCookies = (prefs.getStringList(_getCookieKey(uri)) ?? [])
        .map((cookie) => Cookie.fromSetCookieValue(cookie))
        .toList();
    List<Cookie> updatedCookies = existingCookies;

    for (var newCookie in newCookies) {
      var found = false;
      for (var i = 0; i < updatedCookies.length; i++) {
        if (newCookie.name == updatedCookies[i].name) {
          updatedCookies[i] = newCookie;
          found = true;
          break;
        }
      }
      if (!found) {
        updatedCookies.add(newCookie);
      }
    }
    await prefs.setStringList(
        _getCookieKey(uri), updatedCookies.map((c) => c.toString()).toList());
  }

  @override
  Future<void> delete(Uri uri, [bool withDomainSharedCookie = false]) async {
    SharedPreferences prefs = await _getPrefs();
    var key = _getCookieKey(uri);

    if (withDomainSharedCookie) {
      Iterable<String> keys = prefs.getKeys();
      for (var key in keys) {
        // Note: Parse the key and protect against nulls.
        Uri? parsedKey = Uri.tryParse(key);
        if (parsedKey != null && parsedKey.host == uri.host) {
          await prefs.remove(key);
        }
      }
    } else {
      await prefs.remove(key);
    }
  }

  @override
  Future<void> deleteAll() async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.clear();
  }

  String _getCookieKey(Uri uri) {
    return 'cookies.${uri.scheme}://${uri.host}';
  }
}
