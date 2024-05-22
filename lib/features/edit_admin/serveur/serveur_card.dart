import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe/features/home/models/serveur_model.dart';

class ServeurCardAdmin extends StatelessWidget {
  final Serveur serveur;
  const ServeurCardAdmin({
    super.key,
    required this.serveur,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  Navigator.pushNamed(context, '/product_details', arguments: product);
      },
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'Error',
                  desc: 'voulez-vous supprimer',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    await FirebaseFirestore.instance
                        .collection("serveurs")
                        .doc(serveur.id)
                        .delete();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed("edit_screen");
                  }).show();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),

              child: Image.network(serveur.imageURL,
                  fit: BoxFit.cover, width: 1000.0),
              // child: Text(serveur.name),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(serveur.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w600)),
                  /*  Flexible(
                    child: Text(serveur.price.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
