import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_project/pets/data/models/pet.dart';
import 'package:frist_project/pets/presentation/widgets/pet_grid_tile.dart';

import '../../data/pets_local_datasource/pets_local_datasource.dart';
import '../bloc/pet_bloc.dart';

class AdoptedPage extends StatefulWidget {
  @override
  State<AdoptedPage> createState() => _AdoptedPageState();
}

class _AdoptedPageState extends State<AdoptedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: Text(
          'Adopted page',
        ),
        centerTitle: true,
        leading: Icon(Icons.pets),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (state is PetLoadingState) CircularProgressIndicator(),
                if (state is PetLoadedState)
                  Expanded(
                      child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (_, i) => PetItem(
                      pet: state.pets
                          .where((pet) => pet.isAdopted == true)
                          .toList()[i],
                    ),
                    itemCount: state.pets
                        .where((pet) => pet.isAdopted == true)
                        .toList()
                        .length,
                  )),
              ],
            ),
          );
        },
      ),
    );
  }
}