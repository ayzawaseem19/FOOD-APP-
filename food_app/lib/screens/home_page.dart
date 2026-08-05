import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/menu_data.dart';
import '../models/menu_item.dart';
import '../widgets/menu_item_card.dart';
import '../routes/app_routes.dart';
import '../utils/app_strings.dart';

/// StatefulWidget because search text, the selected category and the
/// cart item count all change while the user interacts with this page.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _query = '';
  String _selectedCategory = AppStrings.allCategory;
  int _cartCount = 0;

  List<String> get _categories => [
        AppStrings.allCategory,
        ...{for (final item in menuItems) item.category},
      ];

  List<MenuItem> get _filteredItems {
    return menuItems.where((item) {
      final matchesCategory = _selectedCategory == AppStrings.allCategory ||
          item.category == _selectedCategory;
      final matchesQuery =
          item.name.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _addToCart(MenuItem item) {
    setState(() => _cartCount++);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.addedToCart(item.name)),
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Column = the page's overall vertical layout: header, search,
        // category row, then the menu grid takes remaining space.
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.greeting,
                          style: TextStyle(color: Colors.black54, fontSize: 13)),
                      Text(AppStrings.findGreatDeals,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => Get.toNamed(AppRoutes.profile),
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Color(0xFFFFE4D9),
                          child: Icon(Icons.person, color: Color(0xFFFF6B35)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => Get.toNamed(AppRoutes.cart),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.shopping_bag_outlined),
                            ),
                            if (_cartCount > 0)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                      minWidth: 18, minHeight: 18),
                                  child: Text(
                                    '$_cartCount',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ---- Search field ----
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10),
                  ],
                ),
                child: TextFormField(
                  onChanged: (value) => setState(() => _query = value),
                  decoration: const InputDecoration(
                    hintText: AppStrings.searchHint,
                    prefixIcon: Icon(Icons.search, size: 22),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            // ---- Category chips ----
            SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => setState(() => _selectedCategory = category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ---- Menu grid takes the remaining vertical space ----
            Expanded(
              child: _filteredItems.isEmpty
                  ? const Center(child: Text(AppStrings.noItemsFound))
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                      itemCount: _filteredItems.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return MenuItemCard(
                          item: item,
                          onTap: () => Get.toNamed(
                            AppRoutes.itemDetail,
                            arguments: item,
                          ),
                          onAddToCart: () => _addToCart(item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
