import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiss_travel_platform/data/auth/repositories/auth_repository_impl.dart';
import 'package:swiss_travel_platform/domain/auth/entities/user.dart';
import 'package:swiss_travel_platform/domain/auth/repositories/auth_repository.dart';
import 'package:swiss_travel_platform/domain/auth/usecases/sign_in_with_google_usecase.dart';

/// AuthRepository 프로바이더
/// 
/// 인증 관련 작업을 수행하는 레포지토리를 제공합니다.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

/// SignInWithGoogleUseCase 프로바이더
/// 
/// Google 로그인 기능을 제공하는 유스케이스를 제공합니다.
final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((ref) {
  return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
});

/// 인증 상태를 관리하는 프로바이더
/// 
/// 이 프로바이더는 다음과 같은 기능을 제공합니다:
/// - 현재 로그인된 사용자 정보 관리
/// - 로그인/로그아웃 기능
/// - 인증 상태 변경 알림
class AuthNotifier extends StateNotifier<User?> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  /// [SignInWithGoogleUseCase]를 주입받아 초기화합니다.
  /// 
  /// 초기 상태는 null (로그인되지 않은 상태) 입니다.
  AuthNotifier({
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
  })  : _signInWithGoogleUseCase = signInWithGoogleUseCase,
        super(null);

  /// Google 계정으로 로그인을 시도합니다.
  /// 
  /// 성공 시 상태가 업데이트되고 true를 반환합니다.
  /// 실패 시 상태는 변경되지 않고 false를 반환합니다.
  Future<bool> signInWithGoogle() async {
    try {
      final user = await _signInWithGoogleUseCase.execute();
      state = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 현재 로그인된 사용자를 로그아웃 처리합니다.
  /// 
  /// 로그아웃 시 상태는 null로 변경됩니다.
  void signOut() {
    state = null;
  }
}

/// 인증 상태를 제공하는 프로바이더
/// 
/// [User] 객체 또는 null을 상태로 가집니다.
/// null인 경우 로그인되지 않은 상태를 의미합니다.
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  final signInWithGoogleUseCase = ref.watch(signInWithGoogleUseCaseProvider);
  return AuthNotifier(signInWithGoogleUseCase: signInWithGoogleUseCase);
}); 