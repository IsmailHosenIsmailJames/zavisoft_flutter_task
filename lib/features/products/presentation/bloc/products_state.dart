import 'package:equatable/equatable.dart';
import '../../domain/models/product.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final Map<int, List<Product>> categoryProducts;
  final List<String> categories;
  final int selectedCategoryIndex;
  final int? loadingCategoryIndex;

  const ProductsLoaded({
    required this.categoryProducts,
    required this.categories,
    required this.selectedCategoryIndex,
    this.loadingCategoryIndex,
  });

  ProductsLoaded copyWith({
    Map<int, List<Product>>? categoryProducts,
    List<String>? categories,
    int? selectedCategoryIndex,
    int? loadingCategoryIndex,
  }) {
    return ProductsLoaded(
      categoryProducts: categoryProducts ?? this.categoryProducts,
      categories: categories ?? this.categories,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      loadingCategoryIndex: loadingCategoryIndex ?? this.loadingCategoryIndex,
    );
  }

  @override
  List<Object?> get props => [
    categoryProducts,
    categories,
    selectedCategoryIndex,
    loadingCategoryIndex,
  ];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
