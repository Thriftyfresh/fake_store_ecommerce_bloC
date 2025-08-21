import 'package:bloc/bloc.dart';
import 'package:fake_store/data/repositories/product_repository_impl.dart';
import 'package:fake_store/data/models/product_model.dart';

abstract class ProductDetailsEvent {}

class LoadProductDetails extends ProductDetailsEvent {
  final int productId;
  LoadProductDetails(this.productId);
}

abstract class ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;
  ProductDetailsLoaded(this.product);
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductRepository productRepository;

  ProductDetailsBloc(this.productRepository) : super(ProductDetailsLoading()) {
    on<LoadProductDetails>((event, emit) async {
      emit(ProductDetailsLoading());
      try {
        final product = await productRepository.getProductById(event.productId);
        emit(ProductDetailsLoaded(product));
      } catch (e) {
        emit(ProductDetailsError(e.toString()));
      }
    });
  }
}
