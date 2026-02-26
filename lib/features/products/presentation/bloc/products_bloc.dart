import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisoft_flutter_task/features/products/domain/models/product.dart';
import '../../data/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository repository;

  List<String> _cachedCategories = [];

  ProductsBloc({required this.repository}) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<ChangeCategory>(_onChangeCategory);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final categories = await repository.getCategories();
      _cachedCategories = categories;

      final products = await repository.getProducts();

      emit(
        ProductsLoaded(
          categoryProducts: {0: products}, // Initial load of category 0
          categories: categories,
          selectedCategoryIndex: 0,
          loadingCategoryIndex: null,
        ),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onChangeCategory(
    ChangeCategory event,
    Emitter<ProductsState> emit,
  ) async {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;

      if (currentState.selectedCategoryIndex == event.categoryIndex) return;

      if (currentState.categoryProducts.containsKey(event.categoryIndex)) {
        // Data already loaded, just update the selected index
        emit(
          currentState.copyWith(
            selectedCategoryIndex: event.categoryIndex,
            loadingCategoryIndex: null,
          ),
        );
        return;
      }

      emit(
        currentState.copyWith(
          loadingCategoryIndex: event.categoryIndex,
          selectedCategoryIndex: event.categoryIndex,
        ),
      );

      try {
        final category = _cachedCategories[event.categoryIndex];
        final products = await repository.getProductsByCategory(category);

        final updatedCategoryProducts = Map<int, List<Product>>.from(
          currentState.categoryProducts,
        );
        updatedCategoryProducts[event.categoryIndex] = products;

        emit(
          currentState.copyWith(
            categoryProducts: updatedCategoryProducts,
            selectedCategoryIndex: event.categoryIndex,
            loadingCategoryIndex: null,
          ),
        );
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductsState> emit,
  ) async {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;

      emit(
        currentState.copyWith(
          loadingCategoryIndex: currentState.selectedCategoryIndex,
        ),
      );

      try {
        final category = _cachedCategories[currentState.selectedCategoryIndex];
        final products = await repository.getProductsByCategory(category);

        final updatedCategoryProducts = Map<int, List<Product>>.from(
          currentState.categoryProducts,
        );
        updatedCategoryProducts[currentState.selectedCategoryIndex] = products;

        emit(
          currentState.copyWith(
            categoryProducts: updatedCategoryProducts,
            loadingCategoryIndex: null,
          ),
        );
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    } else {
      add(LoadProducts());
    }
  }
}
