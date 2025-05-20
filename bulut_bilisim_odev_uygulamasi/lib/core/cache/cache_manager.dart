import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static CacheManager? _instance;
  static CacheManager get instance {
    _instance ??= CacheManager._init();
    return _instance!;
  }

  CacheManager._init();

  Future<SharedPreferences> getInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<void> saveUsername({required String username}) async {
    final prefs = await getInstance();
    await prefs.setString(CacheKeys.username.name, username);
  }

  Future<String?> getUsername() async {
    final prefs = await getInstance();
    return prefs.getString(CacheKeys.username.name);
  }

  Future<void> removeUsername() async {
    final prefs = await getInstance();
    await prefs.remove(CacheKeys.username.name);
  }
}

enum CacheKeys { username }
