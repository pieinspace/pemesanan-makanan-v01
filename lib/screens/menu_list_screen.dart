import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../models/cart_item.dart';
import '../services/menu_service.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../widgets/menu_card.dart';

class MenuListScreen extends StatefulWidget {
  final String category;

  const MenuListScreen({super.key, required this.category});

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  List<MenuItem> _menuItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  void _loadMenuItems() {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _menuItems = MenuService.getMenuByCategory(widget.category);
        _isLoading = false;
      });
    });
  }

  Future<void> _addToCart(MenuItem item) async {
    // Load existing cart
    final cartData = StorageService.getJson(AppConstants.cartStorageKey);
    List<CartItem> cart = [];

    if (cartData != null) {
      cart = (cartData as List).map((item) => CartItem.fromMap(item)).toList();
    }

    // Check if item already in cart
    final existingIndex = cart.indexWhere(
      (cartItem) => cartItem.menuItem.id == item.id,
    );

    if (existingIndex >= 0) {
      // Item exists, increase quantity
      cart[existingIndex].quantity++;
    } else {
      // New item, add to cart
      cart.add(CartItem(menuItem: item));
    }

    // Sort by addedAt (chronological order)
    cart.sort((a, b) => a.addedAt.compareTo(b.addedAt));

    // Save to storage
    final data = cart.map((item) => item.toMap()).toList();
    await StorageService.saveJson(AppConstants.cartStorageKey, data);

    // Show snackbar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text('${item.name} ditambahkan ke keranjang'),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Color _getCategoryColor() {
    switch (widget.category) {
      case 'Makanan':
        return Colors.orange;
      case 'Minuman':
        return Colors.blue;
      case 'Snack':
        return Colors.purple;
      case 'Dessert':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: categoryColor.withOpacity(0.1),
        foregroundColor: categoryColor,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: categoryColor),
                  const SizedBox(height: 16),
                  Text(
                    'Memuat menu...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : _menuItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tidak ada menu tersedia',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Info Banner
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: categoryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: categoryColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${_menuItems.length} menu tersedia',
                              style: TextStyle(
                                color: categoryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Menu List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _menuItems.length,
                        itemBuilder: (context, index) {
                          final item = _menuItems[index];
                          return MenuCard(
                            item: item,
                            onAddToCart: () => _addToCart(item),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}