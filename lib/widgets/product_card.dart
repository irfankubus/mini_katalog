import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';

/// GridView içinde gösterilen ürün kartı.
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        // Kart tıklanınca detay sayfasına, ürün "route argument" olarak gider.
        onTap: () =>
            Navigator.pushNamed(context, '/detail', arguments: product),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: theme.colorScheme.surfaceContainerHighest,
                padding: const EdgeInsets.all(12),
                child: Hero(
                  tag: 'product-${product.id}',
                  child: Image.asset(product.image, fit: BoxFit.contain),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 2, 4, 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      product.priceText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Sepete ekle',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add_shopping_cart),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
