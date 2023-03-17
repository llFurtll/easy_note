import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesEasyNote {
  Future<void> init();
  Future<void> setValue<T>({
    required String identity,
    required T value
  });
  int? getInt({
    required String identity
  });
  double? getDouble({
    required String identity
  });
  bool? getBool({
    required String identity
  });
  String? getString({
    required String identity
  });
  List<String>? getListString({
    required String identity
  });
  Future<void> remove({
    required String identity
  });
}

class SharedPreferencesEasyNoteImpl extends SharedPreferencesEasyNote {
  static SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  @override
  Future<void> setValue<T>({required String identity, required T value}) async {
    if (value is double) {
      await _prefs?.setDouble(identity, value);
    }

    if (value is int) {
      await _prefs?.setInt(identity, value);
    }

    if (value is String) {
      await _prefs?.setString(identity, value);
    }

    if (value is bool) {
      await _prefs?.setBool(identity, value);
    }

    if (value is List<String>) {
      await _prefs?.setStringList(identity, value);
    }
  }
  
  @override
  bool? getBool({required String identity}) {
    return _prefs?.getBool(identity);
  }
  
  @override
  double? getDouble({required String identity}) {
    return _prefs?.getDouble(identity);
  }
  
  @override
  int? getInt({required String identity}) {
    return _prefs?.getInt(identity);
  }
  
  @override
  List<String>? getListString({required String identity}) {
    return _prefs?.getStringList(identity);
  }
  
  @override
  String? getString({required String identity}) {
    return _prefs?.getString(identity);
  }
  
  @override
  Future<void> remove({required String identity}) async {
    await _prefs?.remove(identity);
  }
}