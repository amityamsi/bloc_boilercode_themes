import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/features/demo/theme_test_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/language/language_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/demo/presentation/pages/demo_page.dart';
import '../../features/demo/presentation/pages/rtl_demo_page.dart';
import '../services/api_service.dart';

class AppRouter {
  static final ApiService _apiService = ApiService();
  static final AuthRepository _authRepository = AuthRepositoryImpl(_apiService);

  // Route names for easy access
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String demo = '/demo';
  static const String rtlDemo = '/rtl-demo';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String productDetail = '/product';
  static const String userDetail = '/user';
  static const String category = '/category';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    debugLogDiagnostics: true,
    routes: [
      // Auth Routes
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(authRepository: _authRepository),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: signup,
        name: 'signup',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(authRepository: _authRepository),
          child: const SignupPage(),
        ),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(authRepository: _authRepository),
          child: const ForgotPasswordPage(),
        ),
      ),

      // Home Route
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Demo Route
      GoRoute(
        path: demo,
        name: 'demo',
        builder: (context, state) => const DemoPage(),
      ),

      // RTL Demo Route
      GoRoute(
        path: rtlDemo,
        name: 'rtl-demo',
        builder: (context, state) => const RTLDemoPage(),
      ),

      // Profile Route with parameters
      GoRoute(
        path: '$profile/:userId',
        name: 'profile',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          final showEdit = state.uri.queryParameters['edit'] == 'true';

          return UserProfilePage(
            userId: userId,
            showEdit: showEdit,
          );
        },
      ),

      // Product Detail Route with parameters
      GoRoute(
        path: '$productDetail/:productId',
        name: 'product-detail',
        builder: (context, state) {
          final productId = state.pathParameters['productId']!;
          final categoryId = state.uri.queryParameters['category'];
          final variant = state.uri.queryParameters['variant'];

          return ProductDetailPage(
            productId: productId,
            categoryId: categoryId,
            variant: variant,
          );
        },
      ),

      // User Detail Route with parameters
      GoRoute(
        path: '$userDetail/:userId',
        name: 'user-detail',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          final tab = state.uri.queryParameters['tab'] ?? 'profile';

          return UserDetailPage(
            userId: userId,
            initialTab: tab,
          );
        },
      ),

      // Category Route with parameters
      GoRoute(
        path: '$category/:categoryId',
        name: 'category',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          final sortBy = state.uri.queryParameters['sort'] ?? 'name';
          final filter = state.uri.queryParameters['filter'];

          return CategoryPage(
            categoryId: categoryId,
            sortBy: sortBy,
            filter: filter,
          );
        },
      ),

      // Settings Route
      GoRoute(
        path: settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    redirect: (context, state) {
      // Add authentication logic here if needed
      // Example: Check if user is authenticated for protected routes
      final isAuthenticated = false; // Replace with actual auth check
      final isAuthRoute = state.matchedLocation == login ||
          state.matchedLocation == signup ||
          state.matchedLocation == forgotPassword;

      if (!isAuthenticated && !isAuthRoute) {
        return login;
      }

      if (isAuthenticated && isAuthRoute) {
        return home;
      }

      return null;
    },
    errorBuilder: (context, state) => const ErrorPage(),
  );
}

// Navigation helper class
class AppNavigation {
  // Basic navigation
  static void goToLogin(BuildContext context) => context.go(AppRouter.login);
  static void goToSignup(BuildContext context) => context.go(AppRouter.signup);
  static void goToForgotPassword(BuildContext context) =>
      context.go(AppRouter.forgotPassword);
  static void goToHome(BuildContext context) => context.go(AppRouter.home);
  static void goToDemo(BuildContext context) => context.go(AppRouter.demo);
  static void goToRTLDemo(BuildContext context) =>
      context.go(AppRouter.rtlDemo);
  static void goToSettings(BuildContext context) =>
      context.go(AppRouter.settings);

  // Navigation with path parameters
  static void goToProfile(BuildContext context, String userId) {
    context.go('${AppRouter.profile}/$userId');
  }

  static void goToProductDetail(BuildContext context, String productId) {
    context.go('${AppRouter.productDetail}/$productId');
  }

  static void goToUserDetail(BuildContext context, String userId) {
    context.go('${AppRouter.userDetail}/$userId');
  }

  static void goToCategory(BuildContext context, String categoryId) {
    context.go('${AppRouter.category}/$categoryId');
  }

  // Navigation with query parameters
  static void goToProfileWithEdit(BuildContext context, String userId) {
    context.go('${AppRouter.profile}/$userId?edit=true');
  }

  static void goToProductDetailWithCategory(
      BuildContext context, String productId, String categoryId) {
    context.go('${AppRouter.productDetail}/$productId?category=$categoryId');
  }

  static void goToUserDetailWithTab(
      BuildContext context, String userId, String tab) {
    context.go('${AppRouter.userDetail}/$userId?tab=$tab');
  }

  static void goToCategoryWithSort(
      BuildContext context, String categoryId, String sortBy) {
    context.go('${AppRouter.category}/$categoryId?sort=$sortBy');
  }

  // Navigation with multiple query parameters
  static void goToProductDetailWithVariant(BuildContext context,
      String productId, String categoryId, String variant) {
    context.go(
        '${AppRouter.productDetail}/$productId?category=$categoryId&variant=$variant');
  }

  static void goToCategoryWithFilter(
      BuildContext context, String categoryId, String sortBy, String filter) {
    context.go('${AppRouter.category}/$categoryId?sort=$sortBy&filter=$filter');
  }

  // Push navigation (adds to stack)
  static void pushToProfile(BuildContext context, String userId) {
    context.push('${AppRouter.profile}/$userId');
  }

  static void pushToProductDetail(BuildContext context, String productId) {
    context.push('${AppRouter.productDetail}/$productId');
  }

  // Replace navigation (replaces current route)
  static void replaceWithHome(BuildContext context) {
    context.pushReplacement(AppRouter.home);
  }

  // Pop navigation
  static void pop(BuildContext context) {
    context.pop();
  }

  // Pop until specific route
  static void popUntil(BuildContext context, String route) {
    context.go(route);
  }
}

// Example pages for demonstration
class UserProfilePage extends StatelessWidget {
  final String userId;
  final bool showEdit;

  const UserProfilePage({
    super.key,
    required this.userId,
    this.showEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile - $userId'),
        actions: [
          if (showEdit)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Handle edit action
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Profile: $userId'),
            if (showEdit) const Text('Edit mode enabled'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => AppNavigation.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String productId;
  final String? categoryId;
  final String? variant;

  const ProductDetailPage({
    super.key,
    required this.productId,
    this.categoryId,
    this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product - $productId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product ID: $productId'),
            if (categoryId != null) Text('Category: $categoryId'),
            if (variant != null) Text('Variant: $variant'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => AppNavigation.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final String userId;
  final String initialTab;

  const UserDetailPage({
    super.key,
    required this.userId,
    required this.initialTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User - $userId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User ID: $userId'),
            Text('Initial Tab: $initialTab'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => AppNavigation.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String categoryId;
  final String sortBy;
  final String? filter;

  const CategoryPage({
    super.key,
    required this.categoryId,
    required this.sortBy,
    this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category - $categoryId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Category ID: $categoryId'),
            Text('Sort By: $sortBy'),
            if (filter != null) Text('Filter: $filter'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => AppNavigation.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => AppNavigation.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('The page you are looking for does not exist.'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc Boilerplate'),
        centerTitle: true,
        actions: [
          // Theme toggle button
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              if (state is ThemeLoaded) {
                return IconButton(
                  icon: Icon(
                    state.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  ),
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleTheme());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Language menu
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              if (state is LanguageLoaded) {
                return PopupMenuButton<String>(
                  icon: const Icon(Icons.language),
                  onSelected: (languageCode) {
                    switch (languageCode) {
                      case 'en':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'en', countryCode: 'US'),
                            );
                        break;
                      case 'es':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'es', countryCode: 'ES'),
                            );
                        break;
                      case 'fr':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'fr', countryCode: 'FR'),
                            );
                        break;
                      case 'de':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'de', countryCode: 'DE'),
                            );
                        break;
                      case 'hi':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'hi', countryCode: 'IN'),
                            );
                        break;
                      case 'ar':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'ar', countryCode: 'SA'),
                            );
                        break;
                      case 'he':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'he', countryCode: 'IL'),
                            );
                        break;
                      case 'fa':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'fa', countryCode: 'IR'),
                            );
                        break;
                      case 'ur':
                        context.read<LanguageBloc>().add(
                              const ChangeLanguage(
                                  languageCode: 'ur', countryCode: 'PK'),
                            );
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                    const PopupMenuItem(
                      value: 'es',
                      child: Text('Español'),
                    ),
                    const PopupMenuItem(
                      value: 'fr',
                      child: Text('Français'),
                    ),
                    const PopupMenuItem(
                      value: 'de',
                      child: Text('Deutsch'),
                    ),
                    const PopupMenuItem(
                      value: 'hi',
                      child: Text('हिंदी'),
                    ),
                    const PopupMenuItem(
                      value: 'ar',
                      child: Text('العربية'),
                    ),
                    const PopupMenuItem(
                      value: 'he',
                      child: Text('עברית'),
                    ),
                    const PopupMenuItem(
                      value: 'fa',
                      child: Text('فارسی'),
                    ),
                    const PopupMenuItem(
                      value: 'ur',
                      child: Text('اردو'),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App logo or icon
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ThemeTestPage()));
              },
              child: Icon(
                Icons.security,
                size: 100,
              ),
            ),
            const SizedBox(height: 20),

            // App title
            Text(
              'Flutter Bloc Boilerplate',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),

            // App description
            Text(
              'Your digital security companion',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),

            // Current theme info
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                if (state is ThemeLoaded) {
                  return Text(
                    'Current Theme: ${state.isDarkMode ? 'Dark' : 'Light'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 10),

            // Current language info
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                if (state is LanguageLoaded) {
                  return Text(
                    'Current Language: ${state.getCurrentLanguageName()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 30),

            // Navigation Examples Section
            const Text(
              'Navigation Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Basic Navigation
            const Text('Basic Navigation:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => AppNavigation.goToDemo(context),
                  child: const Text('Demo Page'),
                ),
                ElevatedButton(
                  onPressed: () => AppNavigation.goToSettings(context),
                  child: const Text('Settings'),
                ),
                ElevatedButton(
                  onPressed: () => AppNavigation.goToLogin(context),
                  child: const Text('Login'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Navigation with Parameters
            const Text('Navigation with Parameters:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      AppNavigation.goToProfile(context, 'user123'),
                  child: const Text('User Profile'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      AppNavigation.goToProductDetail(context, 'prod456'),
                  child: const Text('Product Detail'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      AppNavigation.goToCategory(context, 'cat789'),
                  child: const Text('Category'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Navigation with Query Parameters
            const Text('Navigation with Query Parameters:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      AppNavigation.goToProfileWithEdit(context, 'user123'),
                  child: const Text('Profile (Edit Mode)'),
                ),
                ElevatedButton(
                  onPressed: () => AppNavigation.goToProductDetailWithCategory(
                      context, 'prod456', 'cat789'),
                  child: const Text('Product with Category'),
                ),
                ElevatedButton(
                  onPressed: () => AppNavigation.goToUserDetailWithTab(
                      context, 'user123', 'posts'),
                  child: const Text('User with Tab'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Navigation with Multiple Parameters
            const Text('Navigation with Multiple Parameters:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => AppNavigation.goToProductDetailWithVariant(
                      context, 'prod456', 'cat789', 'red'),
                  child: const Text('Product with Variant'),
                ),
                ElevatedButton(
                  onPressed: () => AppNavigation.goToCategoryWithFilter(
                      context, 'cat789', 'price', 'in-stock'),
                  child: const Text('Category with Filter'),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Demo buttons
            const Text('Other Features:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleTheme());
                  },
                  child: const Text('Toggle Theme'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('This is a demo snackbar'),
                      ),
                    );
                  },
                  child: const Text('Show Snackbar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
