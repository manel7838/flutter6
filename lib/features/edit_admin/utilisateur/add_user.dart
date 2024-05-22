import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe/features/edit_admin/utilisateur/delete_user.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddUser> {
  TextEditingController adresse = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController zipCode = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  // ignore: non_constant_identifier_names
  Future<void> AddUsers() {
    return users
        .add({
          "adresse": adresse.text,
          "city": city.text,
          "country": country.text,
          "email": email.text,
          "fullName": fullName.text,
          "phone": phone.text,
          "zipCode": zipCode.text
        })
        .then((value) => print("user added"))
        .catchError((Error) => print("Failed to add server:$Error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 21, 21),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DeleteUser()));
        },
        backgroundColor: const Color.fromARGB(255, 212, 49, 24),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: adresse,
              decoration: _buildInputDecoration(
                "adresse",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: city,
              decoration: _buildInputDecoration(
                "city",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: country,
              decoration: _buildInputDecoration(
                "country",
              ),
            ),
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
            TextFormField(
              controller: fullName,
              decoration: _buildInputDecoration(
                "fullName",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: phone,
              decoration: _buildInputDecoration(
                "phone",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: zipCode,
              decoration: _buildInputDecoration(
                "zipCode",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                AddUsers();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 53, 12)),
              child: const Text(
                "Ajouter utilisateur",
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
