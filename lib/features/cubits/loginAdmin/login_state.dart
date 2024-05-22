part of 'login_cubit.dart';

enum LoginAdminStatus { initial, submitting, success, error }

class LoginAdminState extends Equatable {
  final String email;
  final String password;
  final LoginAdminStatus status;
  final auth.User? user;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const LoginAdminState({
    required this.email,
    required this.password,
    required this.status,
    this.user,
  });

  factory LoginAdminState.initial() {
    return const LoginAdminState(
      email: '',
      password: '',
      status: LoginAdminStatus.initial,
      user: null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, password, status, user];

  LoginAdminState copyWith({
    String? email,
    String? password,
    LoginAdminStatus? status,
    auth.User? user,
  }) {
    return LoginAdminState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
