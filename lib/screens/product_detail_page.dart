import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../widgets/cart_button.dart';

/// Ürün detay sayfası. Ürün, Navigator'dan "route argument" olarak gelir.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sayfalar arası veri taşıma: pushNamed(arguments: product)
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: const [CartButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Container(
            height: 260,
            color: theme.colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.all(20),
            child: Hero(
              tag: 'product-${product.id}',
              child: Image.asset(product.image, fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  product.tagline,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(height: 12),
                Text(
                  '${product.priceText} ${product.currency}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (product.specs.isNotEmpty) ...[
                  Text('Özellikler', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.specs.entries
                        .map((e) => Chip(label: Text('${e.key}: ${e.value}')))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                Text('Açıklama', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(product.description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Sepete Ekle'),
                    onPressed: () {
                      cart.add(product);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('${product.name} sepete eklendi'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
