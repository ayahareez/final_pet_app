import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frist_project/pets/data/models/pet.dart';
import 'package:meta/meta.dart';

import '../../data/pets_local_datasource/pets_local_datasource.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetBloc() : super(PetInitial()) {
    on<PetEvent>((event, emit) async {
      if (event is GetPets) {
        emit(PetLoadingState());
        List<Pet> pets = await PetsLocalDataImpl().getPets();
        emit(PetLoadedState(pets: pets));
      }
      if (event is SetPet) {
        emit(PetLoadingState());
        await PetsLocalDataImpl().setPet(event.pet);
        List<Pet> pets = await PetsLocalDataImpl().getPets();
        emit(PetLoadedState(pets: pets));
      }
      if (event is SetFavPet) {
        emit(PetLoadingState());
        await PetsLocalDataImpl().setFavPet(event.id);
        List<Pet> pets = await PetsLocalDataImpl().getPets();
        emit(PetLoadedState(pets: pets));
      }
      if (event is SetAdoptedPet) {
        emit(PetLoadingState());
        await PetsLocalDataImpl().setAdoptedPet(event.id);
        List<Pet> pets = await PetsLocalDataImpl().getPets();
        emit(PetLoadedState(pets: pets));
      }
    });
  }
}