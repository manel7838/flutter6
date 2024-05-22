import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe/features/home/home_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController capacite = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController remise = TextEditingController();
  //comme l'affiche
  CollectionReference serveurs =
      FirebaseFirestore.instance.collection("serveurs");

  Future<void> addServeur() {
    return serveurs
        .add({
          "capacite": capacite.text,
          "description": description.text,
          "image": image.text,
          "name": name.text,
          "price": price.text,
          "remise": remise.text
        })
        .then((value) => print("serveur added"))
        .catchError((Error) => print("Failed to add server:$Error"));
  }

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
            TextFormField(
              controller: capacite,
              decoration: _buildInputDecoration(
                "Capacite",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: description,
              decoration: _buildInputDecoration(
                "Description",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: image,
              decoration: _buildInputDecoration(
                "Image",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: name,
              decoration: _buildInputDecoration(
                "Name",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: price,
              decoration: _buildInputDecoration(
                "Price",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: remise,
              decoration: _buildInputDecoration(
                "Remise",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                addServeur();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 53, 12)),
              child: const Text(
                "Ajouter serveur",
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
