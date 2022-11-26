import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final String siteName;
  final snap;
  const CommentCard({Key? key, required this.snap, required this.siteName})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('sites')
        .doc(widget.siteName)
        .collection('comments')
        .doc(widget.snap.data()['commentId'])
        .get();

    setState(() {
      rating = (snap.data() as Map<String, dynamic>)['rating'];
    });
    print(snap.data());
    print(rating);
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: widget.snap.data()['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                          text: ' ${widget.snap.data()['text']}',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap.data()['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  RatingBar(
                    ignoreGestures: true,
                    itemSize: 30,
                    onRatingUpdate: (value) {},
                    ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: Colors.amber,
                        ),
                        empty: Icon(
                          Icons.star_outline,
                          color: Colors.amber,
                        )),
                    initialRating: rating,
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   child: const Icon(
          //     Icons.favorite,
          //     size: 16,
          //   ),
          // )
        ],
      ),
    );
  }
}
