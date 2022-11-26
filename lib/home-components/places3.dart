import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/ReUsableCard2.dart';

class Places3 extends StatefulWidget {
  const Places3({super.key});

  @override
  State<Places3> createState() => _Places3State();
}

class _Places3State extends State<Places3> {
  // SiteStorage _siteData = SiteStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sites')
            .where('isMuseum', isEqualTo: true)
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
