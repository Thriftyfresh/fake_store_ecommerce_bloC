part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {
  final int userId;
  LoadCart(this.userId);
}

class AddToCart extends CartEvent {
  final int userId;
  final int productId;
  final int quantity;
  final bool showFeedback;

  AddToCart({
    required this.userId,
    required this.productId,
    this.quantity = 1,
    this.showFeedback = true,
  });
}

class RemoveFromCart extends CartEvent {
  final int userId;
  final int productId;

  RemoveFromCart({required this.userId, required this.productId});
}

class UpdateCartCount extends CartEvent {}

class IncrementQuantity extends CartEvent {
  final int productId;
  IncrementQuantity(this.productId);
}

class DecrementQuantity extends CartEvent {
  final int productId;
  DecrementQuantity(this.productId);
}
