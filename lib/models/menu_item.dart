class MenuItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final int displayOrder;

  MenuItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.displayOrder,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'displayOrder': displayOrder,
    };
  }

  // Create from Map
  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'].toDouble(),
      category: map['category'],
      displayOrder: map['displayOrder'],
    );
  }
}