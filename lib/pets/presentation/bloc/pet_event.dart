part of 'pet_bloc.dart';

@immutable
abstract class PetEvent {}

class GetPets extends PetEvent {}

class SetPet extends PetEvent {
  final Pet pet;

  SetPet({required this.pet});
}

class SetFavPet extends PetEvent {
  final String id;

  SetFavPet({required this.id});
}

class SetAdoptedPet extends PetEvent {
  final String id;

  SetAdoptedPet({required this.id});
}