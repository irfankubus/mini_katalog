import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';

/// Sepet sayfası (simülasyon): ürünler, adet değiştirme ve toplam tutar.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sepetim'),
            actions: [
              if (!cart.isEmpty)
                TextButton(
                  onPressed: cart.clear,
                  child: const Text('Temizle'),
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: cart.isEmpty
              ? const Center(child: Text('Sepetiniz boş.'))
              : Column(
                  children: [
                    // ListView.builder ile dinamik liste
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return ListTile(
                            leading: SizedBox(
                              width: 56,
                              child: Image.asset(item.product.image,
                                  fit: BoxFit.contain),
                            ),
                            title: Text(item.product.name),
                            subtitle: Text(
                              '${item.product.priceText} x ${item.quantity} = '
                              '${formatPrice(item.total)}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Azalt',
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => cart.decrease(item.product),
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  tooltip: 'Artır',
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => cart.add(item.product),
                                ),
                                IconButton(
                                  tooltip: 'Kaldır',
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => cart.remove(item.product),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                      ),
                      child: SafeArea(
                        top: false,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Toplam: ${formatPrice(cart.totalPrice)}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FilledButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Bu bir simülasyondur, ödeme alınmaz.'),
                                  ),
                                );
                              },
                              child: const Text('Siparişi Tamamla'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
