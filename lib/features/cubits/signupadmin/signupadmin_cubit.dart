import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:pfe/features/profile/auth/auth_repository.dart';
import 'package:pfe/features/profile/auth/auth_repository_admin.dart';
import 'package:pfe/features/profile/models/admin_model.dart';

part 'signupadmin_state.dart';

class SignupAdminCubit extends Cubit<SignupAdminState> {
  // final AuthRepository _authRepository;
  final AuthAdminRepository _authRepository;

  SignupAdminCubit({required AuthAdminRepository authRepository})
      : _authRepository = authRepository,
        super(SignupAdminState.initial());

  void userChanged(Admin admin) {
    emit(state.copyWith(
      admin: admin,
      status: SignupAdminStatus.initial,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupAdminStatus.initial));
  }

  Future<void> signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignupAdminStatus.submitting)
      return;
    emit(state.copyWith(status: SignupAdminStatus.submitting));
    try {
      var authAdmin = await _authRepository.signUp(
        password: state.password,
        admin: state.admin!,
      );
      emit(state.copyWith(
          status: SignupAdminStatus.success, authUser: authAdmin));
    } catch (_) {}
  }
}
