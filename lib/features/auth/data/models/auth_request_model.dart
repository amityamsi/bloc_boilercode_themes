import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel extends Equatable {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  @override
  List<Object?> get props => [email, password];
}

@JsonSerializable()
class SignupRequestModel extends Equatable {
  final String email;
  final String password;
  final String name;
  final String? phone;

  const SignupRequestModel({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignupRequestModelToJson(this);

  @override
  List<Object?> get props => [email, password, name, phone];
}

@JsonSerializable()
class ForgotPasswordRequestModel extends Equatable {
  final String email;

  const ForgotPasswordRequestModel({
    required this.email,
  });

  factory ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordRequestModelToJson(this);

  @override
  List<Object?> get props => [email];
}

@JsonSerializable()
class ResetPasswordRequestModel extends Equatable {
  final String token;
  final String password;

  const ResetPasswordRequestModel({
    required this.token,
    required this.password,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);

  @override
  List<Object?> get props => [token, password];
}
