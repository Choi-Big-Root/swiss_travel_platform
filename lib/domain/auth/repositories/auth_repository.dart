import 'package:google_sign_in/google_sign_in.dart';

/// 인증 관련 작업을 처리하는 레포지토리 인터페이스
/// 
/// 이 인터페이스는 소셜 로그인(구글, 카카오 등)과 관련된 모든 인증 작업을 정의합니다.
/// 실제 구현은 [AuthRepositoryImpl] 클래스에서 이루어집니다.
abstract class AuthRepository {
  /// Google 계정을 사용하여 로그인을 시도합니다.
  /// 
  /// 성공 시 [GoogleSignInAccount] 객체를 반환하며, 이 객체에는 사용자의 기본 정보가 포함됩니다.
  /// 실패 시 null을 반환합니다.
  /// 
  /// 주요 반환 정보:
  /// - email: 사용자의 이메일 주소
  /// - displayName: 사용자의 표시 이름
  /// - photoUrl: 프로필 사진 URL
  /// - id: Google 계정의 고유 식별자
  Future<GoogleSignInAccount?> signInWithGoogle();

  /// 현재 로그인된 사용자를 로그아웃 처리합니다.
  /// 
  /// 이 메서드는 다음과 같은 작업을 수행합니다:
  /// 1. Google 로그인 세션 종료
  /// 2. 로컬 인증 상태 초기화
  /// 
  /// 오류가 발생해도 조용히 처리되며, 로그아웃은 항상 성공한 것으로 간주됩니다.
  Future<void> signOut();

  /// 현재 로그인된 사용자 정보를 반환합니다.
  /// 
  /// 로그인된 사용자가 있다면 해당 사용자의 [GoogleSignInAccount] 객체를 반환하고,
  /// 로그인된 사용자가 없다면 null을 반환합니다.
  /// 
  /// 이 메서드는 캐시된 사용자 정보를 반환하므로, 네트워크 요청을 하지 않습니다.
  Future<GoogleSignInAccount?> getCurrentUser();
} 