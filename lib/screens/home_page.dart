import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../models/product.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';

/// Ana sayfa: banner, arama kutusu ve GridView ile ürün listesi.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Product>> _future;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = ProductRepository().loadProducts();
  }

  /// Basit arama/filtreleme: ad veya slogan içinde geçen ürünleri bulur.
  List<Product> _filter(List<Product> products) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return products;
    return products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.tagline.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog'),
        actions: const [CartButton()],
      ),
      body: FutureBuilder<List<Product>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ürünler yüklenemedi: ${snapshot.error}'));
          }

          final products = _filter(snapshot.data ?? []);

          return CustomScrollView(
            slivers: [
              // Banner (Image.asset)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/banner.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Arama kutusu
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Ürün ara...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              if (products.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('Aramanızla eşleşen ürün yok.')),
                )
              else
                // GridView ile ürün kartları
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        ProductCard(product: products[index]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
