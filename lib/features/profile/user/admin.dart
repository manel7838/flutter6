import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe/features/profile/models/admin_model.dart';

class AdminRepository {
  final FirebaseFirestore _firebaseFirestore;

  AdminRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createAdmin(Admin admin) async {
    bool adminExist =
        (await _firebaseFirestore.collection('admin').doc(admin.id).get())
            .exists;

    if (adminExist) {
      return;
    } else {
      await _firebaseFirestore
          .collection('admin')
          .doc(admin.id)
          .set(admin.toDocument());
    }
  }

  Stream<Admin> getAdmin(String adminId) {
    print('Getting user data from Cloud Firestore');
    return _firebaseFirestore
        .collection('admin')
        .doc(adminId)
        .snapshots()
        .map((snap) {
      return Admin.fromSnapshot(snap);
    });
  }
//get all doctors

  Stream<List<Admin>> getDoctors() {
    print('Getting all doctors data from Cloud Firestore');
    return _firebaseFirestore.collection('admin').snapshots().map((snap) {
      return snap.docs.map((doc) => Admin.fromSnapshot(doc)).toList();
    });
  }

  Future<void> updateAdmin(Admin admin) async {
    return _firebaseFirestore
        .collection('admin')
        .doc(admin.id)
        .update(admin.toDocument())
        .then(
          (value) => print('Admin document updated.'),
        );
  }
}
