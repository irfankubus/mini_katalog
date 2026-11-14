import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/main.dart';
import 'package:mini_katalog/models/cart.dart';
import 'package:mini_katalog/models/product.dart';

const _json = {
  'id': 6,
  'name': 'MacBook Pro 16"',
  'tagline': 'Mind-blowing. Head-turning.',
  'description': 'Açıklama',
  'price': '\$2,499',
  'currency': 'USD',
  'image': 'https://wantapi.com/assets/images/macbook.png',
  'specs': {'chip': 'M3 Pro'},
};

void main() {
  group('Product', () {
    test('fromJson fiyatı sayıya ve görseli asset yoluna çevirir', () {
      final p = Product.fromJson(_json);
      expect(p.id, 6);
      expect(p.price, 2499);
      expect(p.image, 'assets/images/macbook.png');
      expect(p.specs['chip'], 'M3 Pro');
      expect(p.priceText, '\$2,499');
    });

    test('toJson alanları geri verir', () {
      final map = Product.fromJson(_json).toJson();
      expect(map['name'], 'MacBook Pro 16"');
      expect(map['price'], 2499);
    });
  });

  group('Cart', () {
    test('ekleme, azaltma ve toplam', () {
      final c = Cart();
      final p = Product.fromJson(_json);
      c.add(p);
      c.add(p);
      expect(c.itemCount, 2);
      expect(c.totalPrice, 4998);
      c.decrease(p);
      expect(c.itemCount, 1);
      c.decrease(p);
      expect(c.isEmpty, isTrue);
    });
  });

  testWidgets('Ana sayfa ürünleri yükler ve detaya gider', (tester) async {
    await tester.pumpWidget(const MiniKatalogApp());
    await tester.pumpAndSettle();

    expect(find.text('Mini Katalog'), findsOneWidget);
    expect(find.text('iPhone 15 Pro'), findsOneWidget);

    await tester.tap(find.text('iPhone 15 Pro'));
    await tester.pumpAndSettle();

    expect(find.text('Sepete Ekle'), findsOneWidget);
    expect(find.text('Açıklama'), findsOneWidget);
  });
}
