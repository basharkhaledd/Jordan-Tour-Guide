import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentText;
  final String uid;
  final String username;
  final String commentId;
  final DateTime datePublished;

  const Comment({
    required this.commentText,
    required this.uid,
    required this.username,
    required this.commentId,
    required this.datePublished,
  });

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comment(
      commentText: snapshot["commentText"],
      uid: snapshot["uid"],
      commentId: snapshot["CommentId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
    );
  }

  Map<String, dynamic> toJson() => {
        "commentText": commentText,
        "uid": uid,
        "username": username,
        "CommentId": commentId,
        "datePublished": datePublished,
      };
}
