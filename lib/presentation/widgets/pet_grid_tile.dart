import 'package:flutter/material.dart';
import 'package:frist_project/data/data_source/pets_local_datasource/pets_local_datasource.dart';
import 'package:frist_project/data/models/pet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source/data_source.dart';
import '../pages/page_pet_info.dart';

class PetItem extends StatefulWidget {
  final Pet pet;
  final Function onFavState;

  const PetItem({super.key, required this.pet, required this.onFavState});

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
                        await PetsLocalDataImpl().setFavPet(widget.pet.id);
                        final pref = await SharedPreferences.getInstance();
                        await PetsLocalDataImpl().getPets();
                        setState(() {});
                        List<String> pets = pref.getStringList('pets') ?? [];
                        print(pets);
                        widget.onFavState();
                      })
                ],
              ),
            ),
            child: Image.asset(
              widget.pet.imageUrl,
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