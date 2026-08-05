import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/menu_item.dart';
import '../utils/app_strings.dart';

/// StatefulWidget because the quantity the user picks changes locally
/// on this page before it's added to the cart.
class MenuItemDetailPage extends StatefulWidget {
  final MenuItem item;

  const MenuItemDetailPage({super.key, required this.item});

  @override
  State<MenuItemDetailPage> createState() => _MenuItemDetailPageState();
}

class _MenuItemDetailPageState extends State<MenuItemDetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ---- Hero image with back/favorite buttons layered via Stack ----
          Stack(
            children: [
              Image.network(
                item.imageUrl,
                width: double.infinity,
                height: 340,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 340,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported_outlined, size: 48),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleIconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Get.back(),
                      ),
                      _circleIconButton(
                        icon: Icons.favorite_border_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ---- Scrollable details fill remaining space ----
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text('${item.rating}',
                                style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(item.category,
                      style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 18),

                  // ---- Quantity selector ----
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(AppStrings.quantity,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      Row(
                        children: [
                          _quantityButton(
                            icon: Icons.remove,
                            onTap: () {
                              if (_quantity > 1) setState(() => _quantity--);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('$_quantity',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                          _quantityButton(
                            icon: Icons.add,
                            onTap: () => setState(() => _quantity++),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  const Text(AppStrings.description,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                        color: Colors.black54, height: 1.5, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // ---- Sticky bottom price + add-to-cart bar ----
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppStrings.totalPrice,
                          style: TextStyle(color: Colors.black54, fontSize: 12)),
                      Text(
                        '\$${(item.price * _quantity).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                AppStrings.addedToCartWithQty(_quantity, item.name)),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          AppStrings.addToCart,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6)],
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _quantityButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F2F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
