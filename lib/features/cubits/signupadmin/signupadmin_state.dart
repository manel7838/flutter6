part of 'signupadmin_cubit.dart';

enum SignupAdminStatus { initial, submitting, success, error }

class SignupAdminState extends Equatable {
  final String password;
  final SignupAdminStatus status;
  final auth.User? authAdmin;
  final Admin? admin;

  bool get isFormValid => admin!.email.isNotEmpty && password.isNotEmpty;

  const SignupAdminState({
    required this.password,
    required this.status,
    this.authAdmin,
    this.admin,
  });

  factory SignupAdminState.initial() {
    return const SignupAdminState(
      password: '',
      status: SignupAdminStatus.initial,
      authAdmin: null,
      admin: Admin(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [password, status, authAdmin, admin];

  SignupAdminState copyWith({
    String? password,
    SignupAdminStatus? status,
    auth.User? authUser,
    Admin? admin,
  }) {
    return SignupAdminState(
      password: password ?? this.password,
      status: status ?? this.status,
      authAdmin: authAdmin ?? authAdmin,
      admin: admin ?? this.admin,
    );
  }
}
