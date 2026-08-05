import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/utils/app_strings.dart' show AppStrings;
import '../routes/app_routes.dart';

/// StatefulWidget because it owns mutable state: the form's validation
/// key, the two text controllers and whether the password is obscured.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: AppStrings.demoEmail);
  final _passwordController =
      TextEditingController(text: AppStrings.demoPassword);
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(
        const Duration(milliseconds: 700)); // fake network call
    if (!mounted) return;
    setState(() => _isLoading = false);
    // offNamed replaces the current route so the user can't swipe/back
    // into the login page again — GetX equivalent of pushReplacementNamed.
    Get.offNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ---- Decorative background blob, positioned with Stack ----
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: -70,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.08),
              ),
            ),
          ),

          // ---- Main scrollable content ----
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.restaurant_rounded,
                          color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      AppStrings.welcomeBack,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 32),
                      child: Text(
                        AppStrings.loginSubtitle,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ),

                    const Text(AppStrings.emailLabel,
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        hint: AppStrings.emailHint,
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.emailRequiredError;
                        }
                        if (!value.contains('@')) {
                          return AppStrings.emailInvalidError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(AppStrings.passwordLabel,
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: _inputDecoration(
                        hint: AppStrings.passwordHint,
                        icon: Icons.lock_outline,
                      ).copyWith(
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return AppStrings.passwordMinLengthError;
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(AppStrings.forgotPassword),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ---- Primary action button built from InkWell ----
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: _isLoading ? null : _handleLogin,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  AppStrings.logIn,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppStrings.noAccountPrompt,
                            style: TextStyle(color: Colors.black54)),
                        TextButton(
                          onPressed: () {},
                          child: const Text(AppStrings.signUp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
