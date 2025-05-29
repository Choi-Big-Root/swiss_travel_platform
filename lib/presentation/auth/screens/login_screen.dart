import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiss_travel_platform/presentation/auth/providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

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
                  switch (authState) {
                    Loading() => const CircularProgressIndicator(),
                    Error(message: final message) => Text(
                        'Error: $message',
                        style: const TextStyle(color: Colors.red),
                      ),
                    _ => Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () =>
                                ref.read(authStateProvider.notifier).signInWithGoogle(),
                            icon: const Icon(Icons.login),
                            label: const Text('Google로 로그인'),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement Kakao login
                            },
                            icon: const Icon(Icons.chat_bubble),
                            label: const Text('카카오로 로그인'),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement Naver login
                            },
                            icon: const Icon(Icons.person),
                            label: const Text('네이버로 로그인'),
                          ),
                        ],
                      ),
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 