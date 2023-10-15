part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SetUserData extends UserEvent {
  final UserData userData;

  SetUserData({required this.userData});
}

class HasSignedUp extends UserEvent {}