class CartModel {
  final int id;
  final int userId;
  final List<CartItem> products;

  CartModel({required this.id, required this.userId, required this.products});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      products: (json['products'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}

class CartItem {
  final int productId;
  int quantity;
  String title;
  double price;
  String image;

  CartItem({
    required this.productId,
    required this.quantity,
    this.title = '',
    this.price = 0.0,
    this.image = '',
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(productId: json['productId'], quantity: json['quantity']);
  }

  CartItem copyWith({
    int? productId,
    int? quantity,
    String? title,
    double? price,
    String? image,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}
