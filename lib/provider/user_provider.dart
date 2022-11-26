import 'package:flutter/material.dart';

import 'package:tour_guide_app/Firebase_Services/firebase_auth.dart';
import 'package:tour_guide_app/Models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  //since we made the user private we use the get method to get the data of the user
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    //notify all the listeners to the user provider that the data of our global variable user has changed so we need to change it's value
    notifyListeners();
  }
}
