part of 'pet_bloc.dart';

@immutable
abstract class PetState {}

class PetInitial extends PetState {}

class PetLoadingState extends PetState {}

class PetLoadedState extends PetState {
  final List<Pet> pets;
  PetLoadedState({required this.pets});
}