import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../utils/app_strings.dart';

/// StatelessWidget — nothing on this page changes on its own; it just
/// displays account info and menu options that navigate elsewhere.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.profile)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Account header card ----
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        'data:image/jpeg;base64,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',
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.demoUserName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            AppStrings.demoEmail,
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.edit_outlined, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ---- Quick stats row ----
              Row(
                children: [
                  Expanded(
                      child: _statCard(context, '4', AppStrings.ordersLabel)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _statCard(context, '10', AppStrings.wishlistLabel)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _statCard(context, '2', AppStrings.reviewsLabel)),
                ],
              ),
              const SizedBox(height: 24),

              const Text(AppStrings.settings,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),

              _menuTile(
                  context, Icons.receipt_long_outlined, AppStrings.orderHistory),
              _menuTile(context, Icons.location_on_outlined,
                  AppStrings.shippingAddress),
              _menuTile(
                  context, Icons.payment_outlined, AppStrings.paymentMethods),
              _menuTile(context, Icons.notifications_none_rounded,
                  AppStrings.notifications),
              _menuTile(context, Icons.help_outline_rounded,
                  AppStrings.helpAndSupport),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  // offAllNamed clears the whole stack — GetX equivalent
                  // of pushNamedAndRemoveUntil(..., (route) => false).
                  onTap: () => Get.offAllNamed(AppRoutes.login),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.logOut,
                      style: TextStyle(
                          color: Colors.red.shade600, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(BuildContext context, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _menuTile(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)],
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 14),
              Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
              const Icon(Icons.chevron_right_rounded, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }
}
