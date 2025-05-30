import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 상단 앱바
          SliverAppBar(
            floating: true,
            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Image.asset('assets/images/logo.png', height: 40),
                  const Spacer(),
                  // 메인 네비게이션 메뉴
                  const Row(
                    children: [
                      _NavItem(title: '융프라우', route: '/vip-passes'),
                      _NavItem(title: '철도패스', route: '/rail-passes'),
                      _NavItem(title: '호텔', route: '/hotels'),
                      _NavItem(title: '여행일정', route: '/schedules'),
                      _NavItem(title: '커뮤니티', route: '/community'),
                    ],
                  ),
                  const SizedBox(width: 20),
                  // 로그인/회원가입 버튼
                  TextButton(
                    onPressed: () {},
                    child: const Text('로그인'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('회원가입'),
                  ),
                ],
              ),
            ),
          ),

          // 메인 비주얼 슬라이더
          SliverToBoxAdapter(
            child: Container(
              height: 500,
              child: PageView(
                children: [
                  _MainVisualItem(
                    imageUrl: 'assets/images/main_visual_1.jpg',
                    title: '스위스 융프라우 여행의 시작',
                    subtitle: '세계에서 가장 아름다운 산악 철도 여행',
                  ),
                  // 추가 슬라이드...
                ],
              ),
            ),
          ),

          // VIP 패스 프로모션
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VIP 패스로 특별한 여행을',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _VipPassCard(
                        title: '융프라우 1일권',
                        price: '213,020원',
                        features: ['전 구간 무제한 이용', '전망대 입장 포함'],
                      ),
                      _VipPassCard(
                        title: '융프라우 3일권',
                        price: '583,530원',
                        features: ['3일간 무제한 이용', '특별 할인 혜택'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 퀵 메뉴 그리드
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate([
                _QuickMenuItem(
                  icon: Icons.train,
                  title: '철도패스 예약',
                  onTap: () => context.go('/rail-passes'),
                ),
                _QuickMenuItem(
                  icon: Icons.hotel,
                  title: '호텔 예약',
                  onTap: () => context.go('/hotels'),
                ),
                _QuickMenuItem(
                  icon: Icons.calendar_today,
                  title: '추천 여행 일정',
                  onTap: () => context.go('/schedules'),
                ),
                _QuickMenuItem(
                  icon: Icons.wb_sunny,
                  title: '실시간 날씨',
                  onTap: () => context.go('/weather'),
                ),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 네비게이션 아이템 위젯
class _NavItem extends StatelessWidget {
  final String title;
  final String route;

  const _NavItem({
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: () => context.go(route),
        child: Text(title),
      ),
    );
  }
}

// 메인 비주얼 아이템 위젯
class _MainVisualItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const _MainVisualItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// VIP 패스 카드 위젯
class _VipPassCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;

  const _VipPassCard({
    required this.title,
    required this.price,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.check, size: 16),
                      const SizedBox(width: 5),
                      Text(feature),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('예약하기'),
            ),
          ],
        ),
      ),
    );
  }
}

// 퀵 메뉴 아이템 위젯
class _QuickMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
} 