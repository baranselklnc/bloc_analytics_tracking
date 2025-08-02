import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/shop/presentation/pages/shop_page.dart';
import '../../features/analytics/presentation/pages/analytics_logs_page.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/shop/bloc/shop_bloc.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (context) => AuthBloc(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/shop',
      builder: (context, state) => BlocProvider(
        create: (context) => ShopBloc(),
        child: const ShopPage(),
      ),
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsLogsPage(),
    ),
  ],
); 