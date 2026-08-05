import 'package:get/get.dart';
import '../models/menu_item.dart';
import '../screens/login_page.dart';
import '../screens/home_page.dart';
import '../screens/cart_page.dart';
import '../screens/profile_page.dart';
import '../screens/item_detail_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.cart, page: () => const CartPage()),
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
    GetPage(
      name: AppRoutes.itemDetail,
      page: () => MenuItemDetailPage(item: Get.arguments as MenuItem),
    ),
  ];
}
