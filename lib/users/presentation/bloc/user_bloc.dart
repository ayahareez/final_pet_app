import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frist_project/users/data/models/user_data.dart';
import 'package:frist_project/users/data/user_local_datasource/user_local_datasource.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserUnauthorized()) {
    on<UserEvent>((event, emit) async {
      if (event is SetUserData) {
        try {
          emit(UserLoadingState());
          await UserLocalDataImpl().setUser(event.userData);
          UserData userData = await UserLocalDataImpl().getUser();
          emit(UserAuthorizedState(userData: userData));
        } catch (e) {
          // Handle the exception here
          emit(UserErrorState(error: 'Failed to set user data.'));
        }
      }
      if (event is HasSignedUp) {
        try {
          final isSigned = await UserLocalDataImpl().hasSignedUP();
          print(isSigned);
          if (isSigned) {
            final UserData userData = await UserLocalDataImpl().getUser();
            emit(UserAuthorizedState(userData: userData));
          } else {
            emit(UserUnauthorized());
          }
        } catch (e) {
          // Handle the exception here
          emit(UserErrorState(error: 'Failed to get user data.'));
        }
      }
    });
  }
}