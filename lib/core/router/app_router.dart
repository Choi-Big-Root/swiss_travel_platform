import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swiss_travel_platform/presentation/auth/providers/auth_provider.dart';
import 'package:swiss_travel_platform/presentation/auth/screens/login_screen.dart';

/// 앱의 라우터 설정
/// 
/// 인증 상태에 따라 적절한 화면으로 리다이렉트합니다:
/// - 로그인하지 않은 경우: 로그인 화면으로 리다이렉트
/// - 로그인한 경우: 요청한 화면으로 이동
final goRouter = GoRouter(
  initialLocation: '/auth',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final isLoggedIn = ProviderScope.containerOf(context).read(authProvider) != null;
    
    if (!isLoggedIn && state.uri.path != '/auth') {
      return '/auth';
    }
    
    if (isLoggedIn && state.uri.path == '/auth') {
      return '/';
    }
    
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

/// 홈 화면
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swiss Travel Platform'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
              context.go('/auth');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('홈 화면'),
      ),
    );
  }
}

/// 지도 화면
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('지도 화면'),
      ),
    );
  }
}

/// 예약 화면
class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('예약 화면'),
      ),
    );
  }
} 