import 'package:flutter/material.dart';

import 'package:tour_guide_app/Firebase_Services/firebase_auth.dart';
import 'package:tour_guide_app/Firebase_Services/firestore_methods.dart';
import 'package:tour_guide_app/Models/Site.dart';

class UserProvider with ChangeNotifier {
  Sites? _site;
  final AuthMethods _authMethods = AuthMethods();
  final FireStoreMethods _firestore = FireStoreMethods();
  //since we made the user private we use the get method to get the data of the user
  Sites get getUser => _site!;

  Future<void> refreshSite() async {
    Sites site = await _firestore.getSiteDetails('');
    _site = site;
    //notify all the listeners to the user provider that the data of our global variable user has changed so we need to change it's value
    notifyListeners();
  }
}
