import 'package:google_sign_in/google_sign_in.dart';
import 'package:swiss_travel_platform/data/auth/models/user_model.dart';
import 'package:swiss_travel_platform/domain/auth/entities/user.dart';
import 'package:swiss_travel_platform/domain/auth/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: 'YOUR_WEB_CLIENT_ID', // Google Cloud Console에서 발급받은 클라이언트 ID
    scopes: ['email', 'profile'],
  );

  @override
  Stream<User?> get authStateChanges => throw UnimplementedError();

  @override
  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google 로그인이 취소되었습니다.');
      }

      final userModel = UserModel(
        id: googleUser.id,
        email: googleUser.email,
        name: googleUser.displayName ?? '',
        profileImage: googleUser.photoUrl,
        provider: AuthProvider.google,
      );
      
      return userModel.toDomain();
    } catch (e) {
      throw Exception('Google 로그인 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<User> signInWithKakao() async {
    // TODO: Implement Kakao Sign In
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithNaver() async {
    // TODO: Implement Naver Sign In
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
} 