part of 'cart_bloc.dart';

abstract class CartState {
  final int totalItems;
  const CartState({this.totalItems = 0});
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdating extends CartState {}

class CartLoaded extends CartState {
  final CartModel cart;

  const CartLoaded(this.cart, int totalItems) : super(totalItems: totalItems);

  @override
  List<Object> get props => [cart, totalItems];
}

class CartActionSuccess extends CartState {
  final String message;
  final CartModel cart;

  const CartActionSuccess({
    required this.message,
    required this.cart,
    required super.totalItems,
  });

  @override
  List<Object> get props => [message, cart, totalItems];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
