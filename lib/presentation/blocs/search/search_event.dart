part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchProducts extends SearchEvent {
  final String query;
  SearchProducts(this.query);
}

class ClearSearch extends SearchEvent {}
