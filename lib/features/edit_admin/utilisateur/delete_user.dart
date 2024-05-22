import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe/features/profile/models/data_model.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteUser> {
  late final User users;
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 21, 21),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: email,
              decoration: _buildInputDecoration(
                "email",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                InkWell(onTap: () {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'voulez-vous supprimer',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(users.email)
                            .delete();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context)
                            .pushReplacementNamed("edit_screen");
                      }).show();
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 53, 12)),
              child: const Text(
                "Supprimer utilisateur",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
        fillColor: const Color.fromARGB(255, 252, 255, 254),
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 124, 137, 136)),
            borderRadius: BorderRadius.circular(30.0)),
        filled: true,
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
  }
}
