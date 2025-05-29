import 'package:swiss_travel_platform/domain/auth/entities/user.dart';
import 'package:swiss_travel_platform/domain/auth/repositories/auth_repository.dart';

/// Google 로그인을 수행하는 유스케이스
/// 
/// 이 유스케이스는 [AuthRepository]를 통해 Google 로그인을 수행하고,
/// 성공 시 [User] 객체를 반환합니다.
/// 실패 시 [AuthException]을 던집니다.
class SignInWithGoogleUseCase {
  final AuthRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  /// Google 로그인을 실행합니다.
  /// 
  /// 성공 시 [User] 객체를 반환합니다.
  /// 실패 시 다음과 같은 예외가 발생할 수 있습니다:
  /// - [AuthException.cancelled]: 사용자가 로그인을 취소한 경우
  /// - [AuthException.failed]: 기타 로그인 실패 (네트워크 오류 등)
  Future<User> execute() async {
    final user = await _repository.signInWithGoogle();
    if (user == null) {
      throw const AuthException.failed('Google 로그인에 실패했습니다.');
    }
    return user;
  }
}

/// 인증 관련 예외
/// 
/// 인증 과정에서 발생할 수 있는 다양한 예외 상황을 나타냅니다.
class AuthException implements Exception {
  final String message;
  final AuthErrorType type;

  const AuthException._(this.message, this.type);

  /// 사용자가 로그인을 취소한 경우
  const AuthException.cancelled([String message = '로그인이 취소되었습니다.'])
      : this._(message, AuthErrorType.cancelled);

  /// 기타 로그인 실패
  const AuthException.failed([String message = '로그인에 실패했습니다.'])
      : this._(message, AuthErrorType.failed);

  @override
  String toString() => message;
}

/// 인증 오류 타입
/// 
/// 발생할 수 있는 다양한 인증 오류의 종류를 정의합니다.
enum AuthErrorType {
  /// 사용자가 로그인을 취소한 경우
  cancelled,
  
  /// 기타 로그인 실패
  failed,
} 