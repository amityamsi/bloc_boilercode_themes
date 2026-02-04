import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';
import '../../data/models/auth_request_model.dart';
import '../../data/repositories/auth_repository.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthSignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String? phone;

  const AuthSignupRequested({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, name, phone];
}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthResetPasswordRequested extends AuthEvent {
  final String token;
  final String password;

  const AuthResetPasswordRequested({
    required this.token,
    required this.password,
  });

  @override
  List<Object?> get props => [token, password];
}

class AuthLogoutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  final String token;

  const AuthAuthenticated({
    required this.user,
    required this.token,
  });

  @override
  List<Object?> get props => [user, token];
}

class AuthUnauthenticated extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthSignupRequested>(_onAuthSignupRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);
    on<AuthResetPasswordRequested>(_onAuthResetPasswordRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _authRepository.getCurrentUser();
    
    if (result.isSuccess && result.user != null && result.token != null) {
      emit(AuthAuthenticated(
        user: result.user!,
        token: result.token!,
      ));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final request = LoginRequestModel(
      email: event.email,
      password: event.password,
    );
    
    final result = await _authRepository.login(request);
    
    if (result.isSuccess && result.user != null && result.token != null) {
      emit(AuthAuthenticated(
        user: result.user!,
        token: result.token!,
      ));
    } else {
      emit(AuthFailure(message: result.message ?? 'Login failed'));
    }
  }

  Future<void> _onAuthSignupRequested(
    AuthSignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final request = SignupRequestModel(
      email: event.email,
      password: event.password,
      name: event.name,
      phone: event.phone,
    );
    
    final result = await _authRepository.signup(request);
    
    if (result.isSuccess && result.user != null && result.token != null) {
      emit(AuthAuthenticated(
        user: result.user!,
        token: result.token!,
      ));
    } else {
      emit(AuthFailure(message: result.message ?? 'Signup failed'));
    }
  }

  Future<void> _onAuthForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final request = ForgotPasswordRequestModel(email: event.email);
    
    final result = await _authRepository.forgotPassword(request);
    
    if (result.isSuccess) {
      emit(AuthSuccess(message: result.message ?? 'Password reset email sent'));
    } else {
      emit(AuthFailure(message: result.message ?? 'Failed to send reset email'));
    }
  }

  Future<void> _onAuthResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final request = ResetPasswordRequestModel(
      token: event.token,
      password: event.password,
    );
    
    final result = await _authRepository.resetPassword(request);
    
    if (result.isSuccess) {
      emit(AuthSuccess(message: result.message ?? 'Password reset successfully'));
    } else {
      emit(AuthFailure(message: result.message ?? 'Failed to reset password'));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _authRepository.logout();
    
    if (result.isSuccess) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthFailure(message: result.message ?? 'Logout failed'));
    }
  }
} 