import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences缓存插件方法封装
class SpUtil {
  static SharedPreferences? _preferences;
  static final SpUtil _instance = SpUtil._();

  SpUtil._();

  static Future<SpUtil> getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  static setLocalStorage<T>(String key, T value) {
    String type = value.runtimeType.toString();

    switch (type) {
      case "String":
        setString(key, value as String);
        break;
      case "int":
        setInt(key, value as int);
        break;
      case "bool":
        setBool(key, value as bool);
        break;
      case "double":
        setDouble(key, value as double);
        break;
      case "List<String>":
        setStringList(key, value as List<String>);
        break;
      case "_InternalLinkedHashMap<String, String>":
        setMap(key, value as Map);
        break;
    }
  }

  /// 获取持久化数据
  static dynamic getLocalStorage<T>(String key) {
    if(_preferences == null) {
      return null;
    }
    dynamic value = _preferences?.get(key);
    if (value.runtimeType.toString() == "String") {
      if (_isJson(value)) {
        return json.decode(value);
      }
    }
    return value;
  }

  static bool _isJson(str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  /// 根据key存储int类型
  static Future<bool>? setInt(String key, int value) {
    return _preferences?.setInt(key, value);
  }

  /// 根据key获取int类型
  static int? getInt(String key, {int defaultValue = 0}) {
    return _preferences?.getInt(key) ?? defaultValue;
  }

  /// 根据key存储double类型
  static Future<bool>? setDouble(String key, double value) {
    return _preferences?.setDouble(key, value);
  }

  /// 根据key获取double类型
  static double? getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences?.getDouble(key) ?? defaultValue;
  }

  /// 根据key存储字符串类型
  static Future<bool>? setString(String key, String value) {
    return _preferences?.setString(key, value);
  }

  /// 根据key获取字符串类型
  static String? getString(String key, {String defaultValue = ""}) {
    return _preferences?.getString(key) ?? defaultValue;
  }

  /// 根据key存储布尔类型
  static Future<bool>? setBool(String key, bool value) {
    return _preferences?.setBool(key, value);
  }

  /// 根据key获取布尔类型
  static bool? getBool(String key, {bool defaultValue = false}) {
    return _preferences?.getBool(key) ?? defaultValue;
  }

  /// 根据key存储字符串类型数组
  static Future<bool>? setStringList(String key, List<String> value) {
    return _preferences?.setStringList(key, value);
  }

  /// 根据key获取字符串类型数组
  static List<String> getStringList(String key,
      {List<String> defaultValue = const []}) {
    return _preferences?.getStringList(key) ?? defaultValue;
  }

  /// 根据key存储Map类型
  static Future<bool>? setMap(String key, Map value) {
    return _preferences?.setString(key, json.encode(value));
  }

  /// 根据key获取Map类型
  static Map getMap(String key) {
    String jsonStr = _preferences?.getString(key) ?? "";
    return jsonStr.isEmpty ? Map : json.decode(jsonStr);
  }
}
