import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swiss_travel_platform/presentation/auth/providers/auth_provider.dart';
import 'package:swiss_travel_platform/presentation/auth/screens/login_screen.dart';
import 'package:swiss_travel_platform/presentation/home/screens/home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// 앱의 라우터 설정
/// 
/// 인증 상태에 따라 적절한 화면으로 리다이렉트합니다:
/// - 로그인하지 않은 경우: 로그인 화면으로 리다이렉트
/// - 로그인한 경우: 요청한 화면으로 이동
final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
    // 홈 화면
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    
    // 인증 화면
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // VIP 패스 관련 라우트
    GoRoute(
      path: '/vip-passes',
      name: 'vipPasses',
      builder: (context, state) => const Scaffold(body: Center(child: Text('VIP 패스 페이지'))),
    ),
    
    // 철도패스 관련 라우트
    GoRoute(
      path: '/rail-passes',
      name: 'railPasses',
      builder: (context, state) => const Scaffold(body: Center(child: Text('철도패스 페이지'))),
    ),
    
    // 호텔 관련 라우트
    GoRoute(
      path: '/hotels',
      name: 'hotels',
      builder: (context, state) => const Scaffold(body: Center(child: Text('호텔 페이지'))),
    ),
    
    // 여행 일정 관련 라우트
    GoRoute(
      path: '/schedules',
      name: 'schedules',
      builder: (context, state) => const Scaffold(body: Center(child: Text('여행 일정 페이지'))),
    ),
    
    // 커뮤니티 관련 라우트
    GoRoute(
      path: '/community',
      name: 'community',
      builder: (context, state) => const Scaffold(body: Center(child: Text('커뮤니티 페이지'))),
    ),

    // 날씨 정보 라우트
    GoRoute(
      path: '/weather',
      name: 'weather',
      builder: (context, state) => const Scaffold(body: Center(child: Text('날씨 정보 페이지'))),
    ),
  ],
  
  // 404 페이지
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('페이지를 찾을 수 없습니다.', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('홈으로 돌아가기'),
          ),
        ],
      ),
    ),
  ),
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