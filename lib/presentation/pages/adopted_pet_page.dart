import 'package:flutter/material.dart';
import 'package:frist_project/data/data_source/pets_local_datasource/pets_local_datasource.dart';
import 'package:frist_project/data/models/pet.dart';
import 'package:frist_project/presentation/widgets/pet_grid_tile.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            child: FutureBuilder(
                future: PetsLocalDataImpl().getPets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (_, i) => PetItem(
                      pet: snapshot.data![i],
                      onFavState: () => setState(() {}),
                    ),
                    itemCount: snapshot.data!
                        .where((pet) => pet.isAdopted == true)
                        .toList()
                        .length,
                  );
                })),
      ),
    );
  }
}