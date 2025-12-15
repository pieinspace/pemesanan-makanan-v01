import '../models/menu_item.dart';
import 'storage_service.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class MenuService {
  static List<MenuItem> _menuItems = [];
  
  static Future<void> initializeMenuData() async {
    debugPrint('🔄 Initializing menu data...');
    
    final existingData = StorageService.getJson(AppConstants.menuStorageKey);
    
    if (existingData != null) {
      debugPrint('📦 Loading existing data...');
      _menuItems = (existingData as List)
          .map((item) => MenuItem.fromMap(item))
          .toList();
    } else {
      debugPrint('✨ Creating initial data...');
      _menuItems = _getInitialMenuData();
      await _saveMenuData();
    }
    
    debugPrint('✅ Menu initialized: ${_menuItems.length} items');
    
    // DEBUG: Print semua menu
    for (var item in _menuItems) {
      debugPrint('   - ${item.category}: ${item.name}');
    }
  }
  
  static List<MenuItem> _getInitialMenuData() {
    return [
      // Makanan
      MenuItem(
        id: 'M001',
        name: 'Nasi Goreng Special',
        imageUrl: '🍛',
        price: 25000,
        category: 'Makanan',
        displayOrder: 1,
      ),
      MenuItem(
        id: 'M002',
        name: 'Mie Goreng',
        imageUrl: '🍜',
        price: 20000,
        category: 'Makanan',
        displayOrder: 2,
      ),
      MenuItem(
        id: 'M003',
        name: 'Ayam Geprek',
        imageUrl: '🍗',
        price: 22000,
        category: 'Makanan',
        displayOrder: 3,
      ),
      MenuItem(
        id: 'M004',
        name: 'Soto Ayam',
        imageUrl: '🍲',
        price: 18000,
        category: 'Makanan',
        displayOrder: 4,
      ),
      MenuItem(
        id: 'M005',
        name: 'Nasi Uduk',
        imageUrl: '🍚',
        price: 15000,
        category: 'Makanan',
        displayOrder: 5,
      ),
      
      // Minuman
      MenuItem(
        id: 'D001',
        name: 'Es Teh Manis',
        imageUrl: '🧋',
        price: 5000,
        category: 'Minuman',
        displayOrder: 1,
      ),
      MenuItem(
        id: 'D002',
        name: 'Jus Jeruk',
        imageUrl: '🍊',
        price: 12000,
        category: 'Minuman',
        displayOrder: 2,
      ),
      MenuItem(
        id: 'D003',
        name: 'Kopi Susu',
        imageUrl: '☕',
        price: 15000,
        category: 'Minuman',
        displayOrder: 3,
      ),
      MenuItem(
        id: 'D004',
        name: 'Es Jeruk',
        imageUrl: '🥤',
        price: 8000,
        category: 'Minuman',
        displayOrder: 4,
      ),
      
      // Snack
      MenuItem(
        id: 'S001',
        name: 'Pisang Goreng',
        imageUrl: '🍌',
        price: 10000,
        category: 'Snack',
        displayOrder: 1,
      ),
      MenuItem(
        id: 'S002',
        name: 'Kentang Goreng',
        imageUrl: '🍟',
        price: 12000,
        category: 'Snack',
        displayOrder: 2,
      ),
      MenuItem(
        id: 'S003',
        name: 'Tahu Crispy',
        imageUrl: '🥡',
        price: 8000,
        category: 'Snack',
        displayOrder: 3,
      ),
      
      // Dessert
      MenuItem(
        id: 'DS001',
        name: 'Es Krim',
        imageUrl: '🍨',
        price: 15000,
        category: 'Dessert',
        displayOrder: 1,
      ),
      MenuItem(
        id: 'DS002',
        name: 'Puding',
        imageUrl: '🍮',
        price: 10000,
        category: 'Dessert',
        displayOrder: 2,
      ),
      MenuItem(
        id: 'DS003',
        name: 'Brownies',
        imageUrl: '🍰',
        price: 18000,
        category: 'Dessert',
        displayOrder: 3,
      ),
    ];
  }
  
  static Future<void> _saveMenuData() async {
    final data = _menuItems.map((item) => item.toMap()).toList();
    await StorageService.saveJson(AppConstants.menuStorageKey, data);
    debugPrint('💾 Menu data saved');
  }
  
  static List<MenuItem> getAllMenuItems() {
    return List.from(_menuItems);
  }
  
  static List<MenuItem> getMenuByCategory(String category) {
    final filtered = _menuItems
        .where((item) => item.category == category)
        .toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    
    debugPrint('🔍 Getting menu for category: $category');
    debugPrint('   Found: ${filtered.length} items');
    
    return filtered;
  }
  
  static bool isDuplicate(String id) {
    return _menuItems.any((item) => item.id == id);
  }
  
  static Future<bool> addMenuItem(MenuItem item) async {
    if (isDuplicate(item.id)) {
      return false;
    }
    
    _menuItems.add(item);
    await _saveMenuData();
    return true;
  }
}