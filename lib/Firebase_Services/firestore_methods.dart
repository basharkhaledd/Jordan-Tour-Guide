import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_guide_app/Models/Site.dart' as model;
import 'package:tour_guide_app/Models/comment.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //function to get the user details so we can then use it in refreshUser
  // get user details
  Future<model.Sites> getSiteDetails(String sitename) async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('sites').doc(sitename).get();

    return model.Sites.fromSnap(documentSnapshot);
  }

  //upload post function
  Future<String> uploadComment(
      String commentText, String uid, String username) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String commentId = const Uuid().v1();
      Comment comment = Comment(
        commentText: commentText,
        uid: uid,
        username: username,
        commentId: commentId,
        datePublished: DateTime.now(),
      );
      _firestore.collection('comments').doc(commentId).set(comment.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//fucntion to add destination to favourites
  Future<String> addFavourite(String sitename) async {
    String userId = await _auth.currentUser!.uid;
    String res = "Some error occurred";
    try {
      await _firestore.collection('sites').doc(sitename).update({
        'favouritedBy': [userId]
      });
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String siteName, String text, String uid,
      String name, double rating) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('sites')
            .doc(siteName)
            .collection('comments')
            .doc(commentId)
            .set({
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'rating': rating,
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
