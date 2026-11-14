import 'package:flutter/foundation.dart';

import 'product.dart';

/// Sepetteki bir satır: ürün + adet.
class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, this.quantity);

  double get total => product.price * quantity;
}

/// Sepet durumu (simülasyon). Değiştiğinde dinleyen ekranlar yeniden çizilir.
class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  /// Sepetteki toplam ürün adedi (AppBar rozeti için).
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.total);

  bool get isEmpty => _items.isEmpty;

  void add(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index == -1) {
      _items.add(CartItem(product, 1));
    } else {
      _items[index].quantity++;
    }
    notifyListeners();
  }

  void decrease(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index == -1) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void remove(Product product) {
    _items.removeWhere((i) => i.product.id == product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// Uygulama genelinde paylaşılan tek sepet (ekstra paket kullanılmadan).
final Cart cart = Cart();
