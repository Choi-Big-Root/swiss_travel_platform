import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swiss_travel_platform/presentation/auth/screens/login_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('홈 화면'),
        ),
      ),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('지도 화면'),
        ),
      ),
    ),
    GoRoute(
      path: '/booking',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('예약 화면'),
        ),
      ),
    ),
  ],
); 