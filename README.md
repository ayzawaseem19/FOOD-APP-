# FOODAPP (Flutter)

A 5-screen food-ordering demo UI built entirely with core Flutter layout
widgets no external UI packages (routing uses the `get` package).

## Pages
1. **Login** (`lib/screens/login_page.dart`) — StatefulWidget, form validation
2. **Home** (`lib/screens/home_page.dart`) — StatefulWidget, search + category filter + menu grid
3. **Item Detail** (`lib/screens/item_detail_page.dart`) — StatefulWidget, quantity selector
4. **Cart** (`lib/screens/cart_page.dart`) — StatefulWidget, editable line items + checkout summary
5. **Profile** (`lib/screens/profile_page.dart`) — StatelessWidget, account info + settings menu

## Run it
```bash
flutter pub get
flutter run
```

## Structure
```
lib/
  main.dart                     # MaterialApp (GetX) + named routes
  models/menu_item.dart         # MenuItem data model
  data/menu_data.dart           # Demo menu catalog
  widgets/menu_item_card.dart   # Reusable Card used in the Home grid
  routes/
    app_routes.dart
    route_managment.dart
  screens/
    login_page.dart
    home_page.dart
    item_detail_page.dart
    cart_page.dart
    profile_page.dart
```
