import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/menu_item.dart';
import '../utils/app_strings.dart';

/// A cart line item pairs a MenuItem with a quantity.
class _CartLine {
  final MenuItem item;
  int quantity;
  _CartLine(this.item, this.quantity);
}

/// StatefulWidget because quantities change and items get removed
/// while the user is on this page.
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Seeded with a couple of demo items so the page isn't empty on open.
  late final List<_CartLine> _lines = [
    _CartLine(menuItems[0], 1),
    _CartLine(menuItems[4], 2),
  ];

  double get _subtotal => _lines.fold(
      0, (sum, line) => sum + line.item.price * line.quantity);
  double get _delivery => _lines.isEmpty ? 0 : 2.99;
  double get _total => _subtotal + _delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.myCart)),
      body: SafeArea(
        child: _lines.isEmpty
            ? const Center(child: Text(AppStrings.cartEmpty))
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                      itemCount: _lines.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final line = _lines[index];
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    line.item.imageUrl,
                                    width: 76,
                                    height: 76,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                      width: 76,
                                      height: 76,
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.image_not_supported_outlined),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        line.item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${line.item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          _stepButton(
                                            icon: Icons.remove,
                                            onTap: () {
                                              setState(() {
                                                if (line.quantity > 1) {
                                                  line.quantity--;
                                                } else {
                                                  _lines.removeAt(index);
                                                }
                                              });
                                            },
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.symmetric(horizontal: 12),
                                            child: Text('${line.quantity}'),
                                          ),
                                          _stepButton(
                                            icon: Icons.add,
                                            onTap: () => setState(() => line.quantity++),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () => setState(() => _lines.removeAt(index)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(Icons.delete_outline,
                                        color: Colors.redAccent, size: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ---- Summary + checkout ----
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12),
                      ],
                    ),
                    child: Column(
                      children: [
                        _summaryRow(AppStrings.subtotal, _subtotal),
                        const SizedBox(height: 6),
                        _summaryRow(AppStrings.delivery, _delivery),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(height: 1),
                        ),
                        _summaryRow(AppStrings.total, _total, isBold: true),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(AppStrings.orderPlaced),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                AppStrings.checkout,
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _summaryRow(String label, double amount, {bool isBold = false}) {
    final style = TextStyle(
      fontSize: isBold ? 16 : 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: isBold ? Colors.black : Colors.black54,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\$${amount.toStringAsFixed(2)}', style: style),
      ],
    );
  }

  Widget _stepButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F2F8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 13),
      ),
    );
  }
}
