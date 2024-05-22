// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class LoginScreenAdmin extends StatelessWidget {
  LoginScreenAdmin({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(formKey.currentContext!)
          .showSnackBar(const SnackBar(content: Text('Login Successfully')));
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Veuillez entrer un email';
    }

    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 5, 204),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 150, right: 20, left: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                    width: 220.w,
                    child: const Text(
                      "se connecter en tant que admin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                const SizedBox(
                  height: 35.0,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration("Email", Icons.email),
                    validator: _validateEmail),
                const SizedBox(
                  height: 25.0,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                    controller: password,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    decoration: _buildInputDecoration("Password", Icons.lock),
                    validator: _validatePassword),
                SizedBox(
                  height: 25.0.h,
                ),
                SizedBox(
                  height: 25.0.h,
                ),
                SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () async {
                          //Envoyer nos informations à la base des données
                          try {
                            print("email is");
                            print(email.text);
                            print("password is");
                            print(password.text);

                            // final credential = await FirebaseAuth.instance
                            //     .signInWithEmailAndPassword(
                            //         email: email.text, password: password.text);

                            final adminSnapshot = await FirebaseFirestore
                                .instance
                                .collection('admin')
                                .where('email', isEqualTo: email.text)
                                .get();
                            final adminData = adminSnapshot.docs.first.data();
                            final adminEmail = adminData['email'];
                            final adminPassword = adminData['password'];
                            print('Admin Email: $adminEmail');
                            print('Admin Password: $adminPassword');

                            // ignore: use_build_context_synchronously
                            if (email.text == adminEmail &&
                                password.text == adminPassword) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushReplacementNamed("delete_screen");
                            }
                          } on FirebaseAuthException catch (e) {
                            print(e.code + "11");
                            if (e.code == 'admin-not-found') {
                              print(e.code + "em");
                              print('No admin found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print(e.code + "pa");
                              print('Wrong password provided for that admin.');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 5, 5, 204)),
                        child: const Text(
                          "se connecter",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ))),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ));
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 124, 137, 136)),
            borderRadius: BorderRadius.circular(30.0)),
        filled: true,
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: Colors.black,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
  }
}
