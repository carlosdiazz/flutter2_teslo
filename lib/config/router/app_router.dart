import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/src/auth/auth.dart';
import 'package:teslo_shop/src/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/src/products/products.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: "/splash",
        builder: (context, state) => CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductScreen(
          productId: state.params["id"] ?? "no-id",
        ),
      ),
    ],
    redirect: (context, state) {
      final isGointTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      print("GoRouter authStatus: $authStatus isGointTo: $isGointTo");

      if (isGointTo == "/splash" && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGointTo == "/login" || isGointTo == "/register") return null;
        return "/login";
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGointTo == "/login" ||
            isGointTo == "/register" ||
            isGointTo == "/splash") return "/";
      }

      return null;
    },

    ///! TODO: Bloquear si no se está autenticado de alguna manera
  );
});

//final appRouter = 