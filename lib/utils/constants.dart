class AppConstants {
  // Charges
  static const double serviceChargeRate = 0.075; // 7.5%
  static const double pb1Rate = 0.10; // 10%
  
  // Categories
  static const List<String> categories = [
    'Makanan',
    'Minuman',
    'Snack',
    'Dessert',
  ];
  
  // Storage Keys
  static const String cartStorageKey = 'cart_items';
  static const String menuStorageKey = 'menu_items';
}