import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiss_travel_platform/features/auth/models/user_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unauthenticated());

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      // TODO: Implement Google Sign In
      state = const AuthState.authenticated(
        user: UserModel(
          id: '1',
          email: 'test@example.com',
          name: 'Test User',
          provider: AuthProvider.google,
        ),
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void signOut() {
    state = const AuthState.unauthenticated();
  }
}

sealed class AuthState {
  const AuthState();

  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated({required UserModel user}) = Authenticated;
  const factory AuthState.loading() = Loading;
  const factory AuthState.error(String message) = Error;
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticated extends AuthState {
  final UserModel user;
  const Authenticated({required this.user});
}

class Loading extends AuthState {
  const Loading();
}

class Error extends AuthState {
  final String message;
  const Error(this.message);
} 