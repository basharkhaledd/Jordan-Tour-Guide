import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tour_guide_app/Provider/user_provider.dart';
import 'package:tour_guide_app/widgets/ReUsableCard2.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
    });
    print(snap.data());
  }

  String userId = '';
  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sites')
            .where('favouritedBy', arrayContains: userId)
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
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                  // horizontal: width > webScreenSize ? width * 0.3 : 0,
                  // vertical: width > webScreenSize ? 15 : 0,
                  ),
              child: ReUsableCard2(
                snap: snapshot.data!.docs[index].data(),
                siteName: '',
              ),
            ),
          );
        },
      ),
    );
  }
}
