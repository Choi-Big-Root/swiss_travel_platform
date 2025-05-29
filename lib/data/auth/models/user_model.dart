import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swiss_travel_platform/domain/auth/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? profileImage,
    @Default(AuthProvider.email) AuthProvider provider,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel._();

  User toDomain() {
    return User(
      id: id,
      email: email,
      name: name,
      profileImage: profileImage,
      provider: provider,
    );
  }
} 