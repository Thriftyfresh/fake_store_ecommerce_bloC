import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class FetchProductsByCategory extends ProductEvent {
  final String category;

  const FetchProductsByCategory(this.category);

  @override
  List<Object> get props => [category];
}
