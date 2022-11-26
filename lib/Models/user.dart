import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;

  const User({
    required this.username,
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
      };

  //here we create a function that will take a documentSnapShot and return a user model,
  //so we dont't have to specify everything in the getUserDetails in AuthMethods.

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
    );
  }
}
