class AppStrings {
  AppStrings._(); 
  // ---- App ----
  static const appName = 'AWFOODS';

  // ---- Login page ----
  static const welcomeBack = 'Welcome back';
  static const loginSubtitle = 'Sign in to order your favorite meals.';
  static const emailLabel = 'Email';
  static const emailHint = 'you@example.com';
  static const emailRequiredError = 'Email is required';
  static const emailInvalidError = 'Enter a valid email';
  static const passwordLabel = 'Password';
  static const passwordHint = 'Enter your password';
  static const passwordMinLengthError = 'Minimum 6 characters';
  static const forgotPassword = 'Forgot password?';
  static const logIn = 'Log In';
  static const noAccountPrompt = "Don't have an account?";
  static const signUp = 'Sign up';
  static const demoEmail = 'ayzawaseem19@gmail.com';
  static const demoPassword = 'AYZA1234';

  // ---- Home page ----
  static const greeting = 'Good afternoon';
  static const findGreatDeals = 'What are you craving?';
  static const searchHint = 'Search dishes...';
  static const noItemsFound = 'No dishes found';
  static const allCategory = 'All';
  static String addedToCart(String itemName) => '$itemName added to cart';

  // ---- Cart page ----
  static const myCart = 'My Order';
  static const cartEmpty = 'Your cart is empty';
  static const subtotal = 'Subtotal';
  static const delivery = 'Delivery';
  static const total = 'Total';
  static const checkout = 'Checkout';
  static const orderPlaced = 'Order placed successfully';

  // ---- Profile page ----
  static const profile = 'Profile';
  static const demoUserName = 'Ayza Waseem';
  static const ordersLabel = 'Orders';
  static const wishlistLabel = 'Favorites';
  static const reviewsLabel = 'Reviews';
  static const settings = 'Settings';
  static const orderHistory = 'Order History';
  static const shippingAddress = 'Delivery Address';
  static const paymentMethods = 'Payment Methods';
  static const notifications = 'Notifications';
  static const helpAndSupport = 'Help & Support';
  static const logOut = 'Log Out';

  // ---- Menu item detail page ----
  static const quantity = 'Quantity';
  static const description = 'Description';
  static const totalPrice = 'Total price';
  static const addToCart = 'Add to Cart';
  static String addedToCartWithQty(int qty, String productName) =>
      '$qty x $productName added to cart';

  // ---- Menu item card ----
  static const hotBadge = 'POPULAR';
}
