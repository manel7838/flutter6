// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:pfe/features/profile/auth/auth_repository_admin.dart';

part 'login_state.dart';

class LoginAdminCubit extends Cubit<LoginAdminState> {
  final AuthAdminRepository _authRepository;

  LoginAdminCubit({required AuthAdminRepository authRepository})
      : _authRepository = authRepository,
        super(LoginAdminState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginAdminStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginAdminStatus.initial));
  }

  Future<void> logInWithCredentials() async {
    if (state.status == LoginAdminStatus.submitting) return;
    emit(state.copyWith(status: LoginAdminStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      print("loggedin");
      final user = auth.FirebaseAuth.instance.currentUser;

      emit(state.copyWith(status: LoginAdminStatus.success));
    } catch (_) {}
  }

  // Future<void> logInWithGoogle() async {
  //   emit(state.copyWith(status:LoginAdminStatus.submitting));
  //   try {
  //     // await _authRepository.logInWithGoogle();
  //     emit(state.copyWith(status:LoginAdminStatus.success));
  //   } catch (_) {}
  // }
}
