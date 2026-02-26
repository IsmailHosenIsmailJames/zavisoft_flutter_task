import 'package:flutter/material.dart';

class ProductsSliverAppBar extends StatelessWidget {
  const ProductsSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      expandedHeight: 200,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.menu, size: 28),
                  Expanded(
                    child: Text(
                      'Zavisoft',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF331E1F)
                      : const Color(0xFFF0EDED),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[500]
                          : Colors.grey[600],
                    ),
                    hintText: 'Search in Daraz',
                    hintStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[400]
                          : Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _PromoItem(
                    color: Colors.orange,
                    label: 'Mega Sale',
                    icon: Icons.local_offer,
                  ),
                  _PromoItem(
                    color: Colors.blue,
                    label: 'Gadgets',
                    icon: Icons.computer,
                  ),
                  _PromoItem(
                    color: Colors.pink,
                    label: 'Jewelry',
                    icon: Icons.diamond,
                  ),
                  _PromoItem(
                    color: Colors.green,
                    label: 'Fashion',
                    icon: Icons.checkroom,
                  ),
                  _PromoItem(
                    color: Colors.purple,
                    label: 'Beauty',
                    icon: Icons.face_retouching_natural,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoItem extends StatelessWidget {
  final MaterialColor color;
  final String label;
  final IconData icon;

  const _PromoItem({
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color.shade700, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
