import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_boilerplate/core/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/auth_request_model.dart';

abstract class AuthRepository {
  Future<AuthResult> login(LoginRequestModel request);
  Future<AuthResult> signup(SignupRequestModel request);
  Future<AuthResult> forgotPassword(ForgotPasswordRequestModel request);
  Future<AuthResult> resetPassword(ResetPasswordRequestModel request);
  Future<AuthResult> logout();
  Future<AuthResult> getCurrentUser();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<AuthResult> login(LoginRequestModel request) async {
    try {
      final response = await _apiService.post('/auth/login', body: request.toJson());
      
      if (response.isSuccess) {
        final data = response.data;
        final token = data['token'] as String;
        final user = UserModel.fromJson(data['user']);
        
        await saveToken(token);
        
        return AuthResult.success(user: user, token: token);
      } else {
        return AuthResult.failure(message: response.message);
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }

  @override
  Future<AuthResult> signup(SignupRequestModel request) async {
    try {
      final response = await _apiService.post('/auth/signup', body: request.toJson());
      
      if (response.isSuccess) {
        final data = response.data;
        final token = data['token'] as String;
        final user = UserModel.fromJson(data['user']);
        
        await saveToken(token);
        
        return AuthResult.success(user: user, token: token);
      } else {
        return AuthResult.failure(message: response.message);
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }

  @override
  Future<AuthResult> forgotPassword(ForgotPasswordRequestModel request) async {
    try {
      final response = await _apiService.post('/auth/forgot-password', body:  request.toJson());
      
      if (response.isSuccess) {
        return AuthResult.success(message: 'Password reset email sent successfully');
      } else {
        return AuthResult.failure(message: response.message);
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }

  @override
  Future<AuthResult> resetPassword(ResetPasswordRequestModel request) async {
    try {
      final response = await _apiService.post('/auth/reset-password', body: request.toJson());
      
      if (response.isSuccess) {
        return AuthResult.success(message: 'Password reset successfully');
      } else {
        return AuthResult.failure(message: response.message);
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }

  @override
  Future<AuthResult> logout() async {
    try {
      await clearToken();
      return AuthResult.success(message: 'Logged out successfully');
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }

  @override
  Future<AuthResult> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) {
        return AuthResult.failure(message: 'No token found');
      }

      final response = await _apiService.get('/auth/me');
      
      if (response.isSuccess) {
        final user = UserModel.fromJson(response.data);
        return AuthResult.success(user: user, token: token);
      } else {
        return AuthResult.failure(message: response.message);
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}

class AuthResult extends Equatable {
  final bool isSuccess;
  final UserModel? user;
  final String? token;
  final String? message;

  const AuthResult._({
    required this.isSuccess,
    this.user,
    this.token,
    this.message,
  });

  factory AuthResult.success({
    UserModel? user,
    String? token,
    String? message,
  }) {
    return AuthResult._(
      isSuccess: true,
      user: user,
      token: token,
      message: message,
    );
  }

  factory AuthResult.failure({required String message}) {
    return AuthResult._(
      isSuccess: false,
      message: message,
    );
  }

  @override
  List<Object?> get props => [isSuccess, user, token, message];
} 