import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisoft_flutter_task/features/products/domain/models/product.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/bloc/products_bloc.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/bloc/products_event.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/bloc/products_state.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/widgets/products_sliver_app_bar.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/widgets/product_grid.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/widgets/sticky_tab_bar_delegate.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(LoadProducts());
  }

  late final TabController _tabController = TabController(
    length: 5,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsInitial || state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ProductsBloc>().add(LoadProducts()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is ProductsLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductsBloc>().add(RefreshProducts());
                  await context.read<ProductsBloc>().stream.firstWhere(
                    (s) =>
                        s is ProductsLoaded && s.loadingCategoryIndex == null,
                  );
                },
                color: Theme.of(context).primaryColor,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      const ProductsSliverAppBar(),

                      SliverPersistentHeader(
                        pinned: true,
                        delegate: StickyTabBarDelegate(
                          tabController: _tabController,
                          categories: state.categories,
                          selectedIndex: state.selectedCategoryIndex,
                          onCategorySelected: (index) {
                            context.read<ProductsBloc>().add(
                              ChangeCategory(index),
                            );
                          },
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: List.generate(state.categories.length, (index) {
                      final hasLoaded = state.categoryProducts.containsKey(
                        index,
                      );
                      final products = state.categoryProducts[index] ?? [];
                      return _CategoryTabView(
                        index: index,
                        products: products,
                        isLoading:
                            state.loadingCategoryIndex == index || !hasLoaded,
                      );
                    }),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CategoryTabView extends StatefulWidget {
  final int index;
  final List<Product> products;
  final bool isLoading;

  const _CategoryTabView({
    required this.index,
    required this.products,
    required this.isLoading,
  });

  @override
  State<_CategoryTabView> createState() => _CategoryTabViewState();
}

class _CategoryTabViewState extends State<_CategoryTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      key: PageStorageKey<String>('page_view_${widget.index}'),
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        if (widget.products.isNotEmpty)
          ProductGrid(products: widget.products)
        else if (widget.isLoading)
          const ProductGridShimmer()
        else
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: Text('No products available.')),
            ),
          ),
      ],
    );
  }
}
