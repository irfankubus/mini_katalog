import 'package:flutter/material.dart';

import '../models/cart.dart';

/// AppBar'daki sepet simgesi; üzerinde sepetteki ürün adedi rozeti görünür.
class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Sepet değiştikçe sadece bu parça yeniden çizilir.
    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        final count = cart.itemCount;
        return IconButton(
          tooltip: 'Sepet',
          onPressed: () => Navigator.pushNamed(context, '/cart'),
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        );
      },
    );
  }
}
