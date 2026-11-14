import 'package:flutter/material.dart';

import 'screens/cart_page.dart';
import 'screens/home_page.dart';
import 'screens/product_detail_page.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      // Named routes ile sayfa geçişleri
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/detail': (context) => const ProductDetailPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
