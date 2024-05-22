import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  final String? id;

  final String email;
  final String password;

  const Admin({this.id, this.email = '', this.password = ''});

  Admin copyWith({
    String? id,
    String? email,
    String? password,
  }) {
    return Admin(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  static const empty = Admin(id: '');
  bool get isEmpty => this == Admin.empty;
  bool get isNotEmpty => this != Admin.empty;

  factory Admin.fromSnapshot(DocumentSnapshot snap) {
    return Admin(id: snap.id, email: snap['email'], password: snap['password']);
  }

  Map<String, Object> toDocument() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [id, email, password];
}
