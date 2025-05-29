import 'package:swiss_travel_platform/domain/auth/entities/user.dart';
import 'package:swiss_travel_platform/domain/auth/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<User> call() async {
    return await _repository.signInWithGoogle();
  }
} 