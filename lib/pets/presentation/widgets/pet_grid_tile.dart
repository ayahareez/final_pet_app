import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frist_project/pets/data/models/pet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/pets_local_datasource/pets_local_datasource.dart';
import '../bloc/pet_bloc.dart';
import '../pages/page_pet_info.dart';

class PetItem extends StatefulWidget {
  final Pet pet;

  const PetItem({super.key, required this.pet});

  @override
  State<PetItem> createState() => _PetItemState();
}

class _PetItemState extends State<PetItem> {
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav = widget.pet.isFav;
  }

  void updateFavoritePet(bool value) async {
    if (widget.pet.isFav) {
      await PetsLocalDataImpl().setFavPet('${widget.pet.id}');
      List<Pet> petts = await PetsLocalDataImpl().getPets();
      print(petts);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final  petProvider = Provider.of<PetProvider>(context);
    //final  isFavorite = petProvider.isPetFavorite(widget.pet);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InfoPage(widget.pet)));
        },
        child: SizedBox(
          width: 120,
          height: 120,
          child: GridTile(
            footer: Container(
              height: 50,
              color: Colors.purple.withOpacity(0.5),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.pet.name,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Checkbox(
                      value: isFav,
                      onChanged: (value) async {
                        // petProvider.toggleFavorite(widget.pet);
                        setState(() {
                          isFav = value!;
                          widget.pet.isFav = value;
                        });
                        context
                            .read<PetBloc>()
                            .add(SetFavPet(id: widget.pet.id));
                      }),
                ],
              ),
            ),
            child: Image.file(
              File(widget.pet.imageUrl),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}