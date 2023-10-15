part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserUnauthorized extends UserState {}

class UserLoadingState extends UserState {}

class UserAuthorizedState extends UserState {
  final UserData userData;

  UserAuthorizedState({required this.userData});
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState({required this.error});
}