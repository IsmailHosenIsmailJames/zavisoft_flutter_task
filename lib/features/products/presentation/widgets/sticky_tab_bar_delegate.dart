import 'package:dartx/dartx_io.dart';
import 'package:flutter/material.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;
  final TabController tabController;

  StickyTabBarDelegate({
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
    required this.tabController,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!
                : Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: tabController,
        tabs: categories
            .map((category) => Tab(text: category.capitalize()))
            .toList(),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        onTap: onCategorySelected,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(covariant StickyTabBarDelegate oldDelegate) {
    return oldDelegate.categories != categories ||
        oldDelegate.selectedIndex != selectedIndex;
  }
}
