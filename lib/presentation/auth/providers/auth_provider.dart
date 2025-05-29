import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiss_travel_platform/data/auth/repositories/auth_repository_impl.dart';
import 'package:swiss_travel_platform/domain/auth/entities/user.dart';
import 'package:swiss_travel_platform/domain/auth/repositories/auth_repository.dart';
import 'package:swiss_travel_platform/domain/auth/usecases/sign_in_with_google_usecase.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((ref) {
  return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(signInWithGoogleUseCaseProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  AuthNotifier(this._signInWithGoogleUseCase)
      : super(const AuthState.unauthenticated());

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _signInWithGoogleUseCase();
      state = AuthState.authenticated(user: user);
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
  const factory AuthState.authenticated({required User user}) = Authenticated;
  const factory AuthState.loading() = Loading;
  const factory AuthState.error(String message) = Error;
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated({required this.user});
}

class Loading extends AuthState {
  const Loading();
}

class Error extends AuthState {
  final String message;
  const Error(this.message);
} 