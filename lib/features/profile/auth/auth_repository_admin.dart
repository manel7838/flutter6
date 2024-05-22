import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:pfe/features/profile/models/admin_model.dart';
import 'package:pfe/features/profile/user/admin.dart';

class AuthAdminRepository {
  final auth.FirebaseAuth _firebaseAuth;
  //final GoogleSignIn _googleSignIn;
  final AdminRepository _adminRepository;

  AuthAdminRepository({
    auth.FirebaseAuth? firebaseAuth,
    // GoogleSignIn? googleSignIn,
    required AdminRepository adminRepository,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        // _googleSignIn = googleSignIn ??
        //      GoogleSignIn.standard(
        //        scopes: ['email'],
        //      ),
        _adminRepository = adminRepository;

  Future<auth.User?> signUp({
    required String password,
    required Admin admin,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
        email: admin.email,
        password: password,
      )
          .then((value) {
        _adminRepository.createAdmin(
          admin.copyWith(id: value.user!.uid),
        );
      });
    } catch (_) {}
    return null;
  }

  // @override
  // Future<void> logInWithGoogle() async {
  //   try {
  //     late final auth.AuthCredential credential;

  //     final googleUser = await _googleSignIn.signIn();
  //     final googleAuth = await googleUser!.authentication;

  //     credential = auth.GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     _firebaseAuth.signInWithCredential(credential).then(
  //       (value) {
  //         _userRepository.createUser(
  //           User(
  //             id: value.user!.uid,
  //             fullName: value.user!.displayName ?? '',
  //             email: value.user!.email ?? '',
  //           ),
  //         );
  //       },
  //     );
  //   } catch (_) {}
  // }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  Stream<auth.User?> get admin => _firebaseAuth.userChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
