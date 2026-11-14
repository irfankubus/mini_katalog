/// Katalogdaki bir ürünü temsil eden model sınıfı.
class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final double price;
  final String currency;

  /// Görselin asset yolu, örn. `assets/images/iphone.png`
  final String image;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  /// JSON'dan nesne üretir. JSON'daki fiyat `"$2,499"` gibi metindir,
  /// sayıya çevrilir. Görsel adresinin sadece dosya adı alınıp yerel asset
  /// yoluna dönüştürülür.
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = (json['specs'] as Map<String, dynamic>?) ?? {};
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: (json['tagline'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      price: _parsePrice(json['price']),
      currency: (json['currency'] as String?) ?? 'USD',
      image: 'assets/images/${(json['image'] as String).split('/').last}',
      specs: rawSpecs.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  /// Nesneyi JSON'a çevirir (fiyat sayı olarak yazılır).
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tagline': tagline,
        'description': description,
        'price': price,
        'currency': currency,
        'image': image,
        'specs': specs,
      };

  /// Ekranda gösterim için: 2499.0 -> "$2,499"
  String get priceText => formatPrice(price);

  static double _parsePrice(dynamic value) {
    if (value is num) return value.toDouble();
    final cleaned = value.toString().replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }
}

/// Fiyatı binlik ayraçlı "$1,299" biçiminde yazar.
String formatPrice(double value) {
  final digits = value.round().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return '\$$buffer';
}
