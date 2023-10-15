import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../data/models/pet.dart';
import '../../data/pets_local_datasource/pets_local_datasource.dart';
import '../bloc/pet_bloc.dart';
import '../widgets/pet_grid_tile.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  List<Pet> pettt = [];

  // getFav() async {
  //   pett = await PetsLocalDataImpl().getPets();
  //   print(pett);
  //   setState(() {});
  //   return pett;
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getFav();
  // }
  //pett
  //.where((pet) => pet.isFav == true)
  //.toList()[index]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text(
          'Favorite Pets',
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(Icons.favorite),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (BuildContext context, int index) => PetItem(
                        pet: state.pets
                            .where((pet) => pet.isFav == true)
                            .toList()[index],
                      ),
                      itemCount: state.pets
                          .where((pet) => pet.isFav == true)
                          .toList()
                          .length,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}