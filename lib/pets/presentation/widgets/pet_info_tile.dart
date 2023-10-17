import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frist_project/pets/data/models/pet.dart';

import '../../data/pets_local_datasource/pets_local_datasource.dart';
import '../bloc/pet_bloc.dart';

class InfoTile extends StatelessWidget {
  final Pet pet;

  InfoTile(this.pet, {super.key});

  bool isAdopted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'ID # ${pet.id} ${pet.name}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener<PetBloc, PetState>(
        listener: (context, state) {
          if (state is PetLoadedState) {
            Fluttertoast.showToast(
                msg: "Adopted",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.purple,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.file(
                  File(pet.imageUrl),
                  fit: BoxFit.fill,
                ),
                Text(
                  'ID: ${pet.id}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Name: ${pet.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Tips:',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${pet.tips}'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<PetBloc>().add(SetAdoptedPet(id: pet.id));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple),
                    child: const Text('ADOPT',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}