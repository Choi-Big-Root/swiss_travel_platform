import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiss_travel_platform/presentation/auth/providers/auth_provider.dart';

/// 로그인 화면
/// 
/// 소셜 로그인 버튼들을 제공하는 화면입니다.
/// 현재 지원하는 로그인 방식:
/// - Google 로그인
/// - Kakao 로그인 (준비 중)
/// - Naver 로그인 (준비 중)
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    
    try {
      final success = await ref.read(authProvider.notifier).signInWithGoogle();
      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그인에 실패했습니다.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);

    // 이미 로그인된 경우 홈 화면으로 리다이렉트
    if (user != null) {
      // TODO: Navigate to home screen
      return const Center(child: Text('로그인 성공!'));
    }

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Swiss Travel Platform',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _handleGoogleSignIn,
                          icon: const Icon(Icons.login),
                          label: const Text('Google로 로그인'),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement Kakao login
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('준비 중입니다.')),
                            );
                          },
                          icon: const Icon(Icons.chat_bubble),
                          label: const Text('카카오로 로그인'),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement Naver login
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('준비 중입니다.')),
                            );
                          },
                          icon: const Icon(Icons.person),
                          label: const Text('네이버로 로그인'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 