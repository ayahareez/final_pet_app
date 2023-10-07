import 'dart:convert';

import 'package:frist_project/data/models/pet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_source.dart';

abstract class PetsLocalData {
  ///this function returns all [Pet]s from the [SharedPreferences]
  ///and it takes no parameter
  Future<List<Pet>> getPets();

  ///this function adds [Pet] to the [SharedPreferences]
  ///and it takes [Pet] object as parameter
  Future<void> setPet(Pet pet);

  ///this function adds Favorite [Pet] to the [SharedPreferences]
  ///and it takes [Pet] object as parameter
  Future<void> setFavPet(String id);

  ///this function deletes all  [Pet]s from the [SharedPreferences]
  ///and it takes nothing as parameter
  Future<void> deletePets();

  /// this function adds Adopted [Pet] to the [SharedPreferences]
  /// and it takes the [Pet] id as parameter
  Future<void> setAdoptedPet(String id);

}

class PetsLocalDataImpl extends PetsLocalData {
  String petsKey = 'pets';

  @override
  Future<void> setPet(Pet pet) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String petData = jsonEncode(pet.toMap());
    final List<String> petsJson = preferences.getStringList(petsKey) ?? [];
    petsJson.add(petData);
    preferences.remove(petsKey);
    await preferences.setStringList(petsKey, petsJson);
  }

  @override
  Future<List<Pet>> getPets() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final List<String> petsJson = preferences.getStringList(petsKey) ?? [];

    List<Pet> pets = [];
    for (int i = 0; i < petsJson.length; i++) {
      final Map<String, dynamic> petMap = jsonDecode(petsJson[i]);
      Pet pet = Pet.fromMap(petMap);
      pets.add(pet);
    }
    return pets;
  }

  @override
  Future<void> deletePets() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(petsKey);
  }


  // Future<void> addPetsFirst() async {
  //   for (int i = 0; i < pets.length; i++) {
  //     await setPet(pets[i]);
  //   }
  // }

  @override
  Future<void> setFavPet(String id) async {
    List<Pet> pets = await getPets();
    Pet? pet;
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id == id) {
        pet = pets[i];
        break;
      }
    }
    if (pet == null) throw Exception('Pet Not Found');
    pet.isFav = !pet.isFav;

    final pref = await SharedPreferences.getInstance();
    pref.remove(petsKey);
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id != id) {
        setPet(pets[i]);
      } else {
        setPet(pet);
      }
    }
  }

  @override
  Future<void> setAdoptedPet(String id) async {
    List<Pet> pets = await getPets();
    Pet? pet;
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id == id) {
        pet = pets[i];
        break;
      }
    }
    if (pet == null) throw Exception('Not Found');
    pet.isAdopted = true;
    final pref = await SharedPreferences.getInstance();
    pref.remove(petsKey);
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id != pet.id) {
        await setPet(pets[i]);
      } else {
        setPet(pet);
      }
    }
  }
}