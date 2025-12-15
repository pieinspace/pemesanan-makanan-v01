import 'dart:convert';
import 'package:flutter/material.dart';

// Simulasi penyimpanan lokal (gunakan shared_preferences di production)
class StorageService {
  static final Map<String, String> _storage = {};
  
  static Future<void> init() async {
    // Initialize storage
    debugPrint('Storage Service Initialized');
  }
  
  static Future<void> saveString(String key, String value) async {
    _storage[key] = value;
    debugPrint('Saved: $key');
  }
  
  static String? getString(String key) {
    return _storage[key];
  }
  
  static Future<void> remove(String key) async {
    _storage.remove(key);
  }
  
  static Future<void> saveJson(String key, dynamic data) async {
    final jsonString = jsonEncode(data);
    await saveString(key, jsonString);
  }
  
  static dynamic getJson(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }
}