import 'dart:convert';

import 'package:frist_project/data/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalData {
  ///this function returns a [UserData] from the[shared_preference]
  ///takes no parameter
  Future<UserData> getUser();

  ///this function adds a [UserDta] to the [shared_preference]
  ///takes [UserDta] as parameter
  Future<void> setUser(UserData userData);

  ///this function checks if the specific user has signed up and his data is in the [shared_preference]
  Future<bool> hasSignedUP();
}

class UserLocalDataImpl implements UserLocalData {
  String userKey = 'SignedUp user';

  @override
  Future<UserData> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final String? result = pref.getString(userKey);
    late UserData userData;
    if (result != null) {
      final Map<String, dynamic> user = jsonDecode(result);
      userData = UserData.fromMap(user);
    } else {
      throw Exception('not found');
    }
    return userData;
  }

  @override
  Future<bool> hasSignedUP() async {
    final pref = await SharedPreferences.getInstance();
    String? result = pref.getString(userKey);
    return result != null;
  }

  @override
  Future<void> setUser(UserData userData) async {
    final pref = await SharedPreferences.getInstance();
    final String user = jsonEncode(userData.toMap());
    await pref.setString('SignedUp user', user);
  }

  Future<void> logOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('SignedUp user');
  }
}