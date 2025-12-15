import 'menu_item.dart';

class CartItem {
  final MenuItem menuItem;
  int quantity;
  final DateTime addedAt;

  CartItem({
    required this.menuItem,
    this.quantity = 1,
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();

  double get subtotal => menuItem.price * quantity;

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'menuItem': menuItem.toMap(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  // Create from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      menuItem: MenuItem.fromMap(map['menuItem']),
      quantity: map['quantity'],
      addedAt: DateTime.parse(map['addedAt']),
    );
  }
}