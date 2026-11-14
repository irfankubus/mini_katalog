import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

/// Ürünleri yerel JSON dosyasından (assets/data/products.json) okur.
/// Bu, bir API çağrısının simülasyonudur.
class ProductRepository {
  static const String _path = 'assets/data/products.json';

  Future<List<Product>> loadProducts() async {
    final text = await rootBundle.loadString(_path);
    final decoded = jsonDecode(text) as Map<String, dynamic>;
    final list = decoded['data'] as List<dynamic>;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
