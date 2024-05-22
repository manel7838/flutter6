import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe/features/home/models/serveur_model.dart';

class ServeurService {
  static Future<List<Serveur>> getServers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('serveurs').get();

    List<Serveur> serveursList =
        querySnapshot.docs.map((doc) => Serveur.fromSnapshot(doc)).toList();

    return serveursList;
  }
}
