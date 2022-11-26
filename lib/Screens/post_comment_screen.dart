import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_app/Firebase_Services/firestore_methods.dart';
import 'package:tour_guide_app/utils/colors.dart';
import 'package:tour_guide_app/utils/utils.dart';

import '../widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  final siteName;
  const CommentsScreen({Key? key, required this.siteName}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  void postComment(String uid, String name, double rating) async {
    try {
      String res = await FireStoreMethods().postComment(
        widget.siteName,
        commentEditingController.text,
        uid,
        name,
        rating,
      );

      if (res != 'success') {
        showSnackBar(context, res);
      }
      setState(() {
        commentEditingController.text = "";
      });
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userId = (snap.data() as Map<String, dynamic>)['uid'];
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
    print(snap.data());
  }

  String userId = '';
  String username = '';
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sites')
            .doc(widget.siteName)
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => CommentCard(
              siteName: widget.siteName,
              snap: snapshot.data!.docs[index],
            ),
          );
        },
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          // height: kToolbarHeight,
          height: 100,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Column(
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(user.photoUrl),
                  //   radius: 18,
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: TextField(
                        controller: commentEditingController,
                        decoration: InputDecoration(
                          hintText: 'Comment as $username',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => postComment(
                      userId,
                      username,
                      rating,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: const Text(
                        'Post',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text('rate the place:'),
                  const SizedBox(
                    width: 10,
                  ),
                  RatingBar.builder(
                      itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (value) => setState(() {
                            this.rating = value;
                          }),
                      minRating: 1),
                  SizedBox(
                    width: 10,
                  ),
                  Text("$rating")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
