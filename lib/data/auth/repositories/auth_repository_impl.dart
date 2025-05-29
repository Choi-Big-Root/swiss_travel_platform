import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swiss_travel_platform/domain/auth/repositories/auth_repository.dart';

/// [AuthRepository] 인터페이스의 실제 구현체
/// 
/// Google 로그인 관련 기능을 구현하며, [GoogleSignIn] 인스턴스를 사용하여
/// 실제 인증 작업을 수행합니다.
/// 
/// 환경 변수에서 클라이언트 ID를 가져와 사용하며, 이메일과 프로필 정보에 대한
/// 접근 권한을 요청합니다.
class AuthRepositoryImpl implements AuthRepository {
  /// Google 로그인을 위한 [GoogleSignIn] 인스턴스
  /// 
  /// [clientId]는 .env 파일에서 가져오며, 웹 플랫폼에서만 사용됩니다.
  /// [scopes]는 요청할 권한 범위를 지정합니다:
  /// - email: 사용자의 이메일 주소 접근 권한
  /// - profile: 사용자의 기본 프로필 정보 접근 권한
  final _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['GOOGLE_CLIENT_ID'],
    scopes: ['email', 'profile'],
  );

  @override
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      // Google 로그인 다이얼로그를 표시하고 사용자의 계정 선택을 기다립니다.
      final account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      // 로그인 실패 시 에러를 콘솔에 출력하고 null을 반환합니다.
      // 주요 실패 원인:
      // 1. 사용자가 로그인을 취소한 경우
      // 2. 네트워크 오류
      // 3. Google 서비스 초기화 실패
      print('Google 로그인 에러: $error');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // Google 로그인 세션을 종료합니다.
      // 이 메서드는 내부적으로 웹의 경우 구글 인증 쿠키도 제거합니다.
      await _googleSignIn.signOut();
    } catch (error) {
      // 로그아웃 실패 시 에러를 콘솔에 출력합니다.
      // 대부분의 경우 로그아웃은 실패하지 않으므로, 
      // 이 에러는 네트워크 문제나 예기치 않은 상황에서만 발생합니다.
      print('로그아웃 에러: $error');
    }
  }

  @override
  Future<GoogleSignInAccount?> getCurrentUser() async {
    // 현재 로그인된 사용자 정보를 반환합니다.
    // 이 정보는 로컬에 캐시된 정보이므로 네트워크 요청이 발생하지 않습니다.
    return _googleSignIn.currentUser;
  }
} 