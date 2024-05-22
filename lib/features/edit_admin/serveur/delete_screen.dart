import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pfe/features/edit_admin/serveur/add_screen.dart';
import 'package:pfe/features/edit_admin/serveur/serveur_card.dart';
import 'package:pfe/features/edit_admin/utilisateur/add_user.dart';
import 'package:pfe/features/home/blocs/serveur_bloc.dart';
import 'package:pfe/features/home/blocs/serveur_state.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 229, 21, 21),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddScreen()));
          },
          backgroundColor: const Color.fromARGB(255, 212, 49, 24),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            alignment: Alignment.topCenter,
            // color: Colors.blue,
            width: double.infinity,
            height: 700.h,
            child: BlocBuilder<ServeurBloc, ServeurState>(
                builder: (context, state) {
              print(state);
              if (state is ServeurLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }
              if (state is ServeurLoaded) {
                return GridView.builder(
                  itemCount: state.serveurs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ServeurCardAdmin(serveur: state.serveurs[index]),
                  ),
                );
              } else {
                return const Text('Something went wrong.');
              }
            }),
          ),
        ));
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.medical_services_sharp),
            title: const Text("Serveurs"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person_3_rounded),
            title: const Text("Utilisateurs"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddUser()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashbord"),
            onTap: () {},
          )
        ],
      );
}
