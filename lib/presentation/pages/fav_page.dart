import 'package:flutter/material.dart';
import 'package:frist_project/data/data_source/data_source.dart';
import 'package:frist_project/data/data_source/pets_local_datasource/pets_local_datasource.dart';
import 'package:frist_project/data/models/user_data.dart';
import 'package:provider/provider.dart';

import '../../data/models/pet.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: PetsLocalDataImpl().getPets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            PetItem(
                          pet: snapshot.data!
                              .where((pet) => pet.isFav == true)
                              .toList()[index],
                          onFavState: () => setState(() {}),
                        ),
                        itemCount: snapshot.data!
                            .where((pet) => pet.isFav == true)
                            .toList()
                            .length,
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}