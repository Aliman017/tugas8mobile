import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  static const String _themeKey = 'theme_key';

  // ========= CHALLENGE: SIMPAN NAMA =========
  String _username = '';
  String get username => _username;
  static const String _nameKey = 'name_key';
  // ==========================================

  ThemeProvider() {
    _loadTheme();
    _loadName(); // tambahan challenge
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isOn);
  }

  // ========= CHALLENGE: LOAD NAMA =========
  void _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString(_nameKey) ?? '';
    notifyListeners();
  }

  // ========= CHALLENGE: SAVE NAMA =========
  void saveName(String name) async {
    _username = name;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_nameKey, name);
  }
}