import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';
import 'services/menu_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // FORCE CLEAR - hapus data lama (untuk testing)
  await StorageService.init();
  await StorageService.remove('menu_items');  // Clear old data
  
  // Initialize fresh
  await MenuService.initializeMenuData();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemesanan Makanan V.O.1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}