import 'package:bloc/bloc.dart';
import 'package:fake_store/data/models/cart_model.dart';
import 'package:fake_store/data/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartCount>(_onUpdateCartCount);
    on<IncrementQuantity>(_onIncrementQuantity);
    on<DecrementQuantity>(_onDecrementQuantity);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await cartRepository.getUserCart(event.userId);
      emit(CartLoaded(cart, _calculateTotalItems(cart)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      
      try {
        await cartRepository.addProductToExistingCart(
          currentState.cart,
          event.productId,
          event.quantity,
        );
        
        emit(CartLoaded(currentState.cart, _calculateTotalItems(currentState.cart)));
        
        // Show success feedback
        if (event.showFeedback) {
          emit(
            CartActionSuccess(
              message: 'Added to cart',
              cart: currentState.cart,
              totalItems: _calculateTotalItems(currentState.cart),
            ),
          );
          await Future.delayed(const Duration(seconds: 1));
          emit(CartLoaded(currentState.cart, _calculateTotalItems(currentState.cart)));
        }
      } catch (e) {
        emit(CartError('Failed to add product: ${e.toString()}'));
      }
    } else {
      // If cart not loaded, load it first then add the product
      emit(CartLoading());
      try {
        final cart = await cartRepository.getUserCart(event.userId);
        emit(CartLoaded(cart, _calculateTotalItems(cart)));
        add(AddToCart(
          userId: event.userId,
          productId: event.productId,
          quantity: event.quantity,
          showFeedback: event.showFeedback,
        ));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      emit(CartUpdating());
      try {
        // Implement your remove logic here
        // final updatedCart = await cartRepository.removeFromCart(...);
        // emit(CartLoaded(updatedCart, _calculateTotalItems(updatedCart)));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  void _onUpdateCartCount(UpdateCartCount event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(
        CartLoaded(currentState.cart, _calculateTotalItems(currentState.cart)),
      );
    }
  }

  int _calculateTotalItems(CartModel cart) {
    return cart.products.fold(0, (sum, item) => sum + item.quantity);
  }

  double _calculateTotalPrice(CartModel cart) {
    return cart.products.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _onIncrementQuantity(IncrementQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      for (final item in currentState.cart.products) {
        if (item.productId == event.productId) {
          item.quantity++;
          break;
        }
      }
      emit(CartLoaded(currentState.cart, _calculateTotalItems(currentState.cart)));
    }
  }

  void _onDecrementQuantity(DecrementQuantity event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      for (int i = 0; i < currentState.cart.products.length; i++) {
        final item = currentState.cart.products[i];
        if (item.productId == event.productId) {
          if (item.quantity > 1) {
            item.quantity--;
          } else {
            // Remove item from cart when quantity would go to 0
            currentState.cart.products.removeAt(i);
          }
          break;
        }
      }
      emit(CartLoaded(currentState.cart, _calculateTotalItems(currentState.cart)));
    }
  }
}
