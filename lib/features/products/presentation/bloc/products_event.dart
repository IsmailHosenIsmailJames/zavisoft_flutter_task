import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {}

class ChangeCategory extends ProductsEvent {
  final int categoryIndex;

  const ChangeCategory(this.categoryIndex);

  @override
  List<Object?> get props => [categoryIndex];
}

class RefreshProducts extends ProductsEvent {}
