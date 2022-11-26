import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/ReUsableCard2.dart';

class Places4 extends StatefulWidget {
  const Places4({super.key});

  @override
  State<Places4> createState() => _Places4State();
}

class _Places4State extends State<Places4> {
  // SiteStorage _siteData = SiteStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sites')
            .where('isRestaurant', isEqualTo: true)
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
