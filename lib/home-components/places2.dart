import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/ReUsableCard2.dart';

class Places2 extends StatefulWidget {
  const Places2({super.key});

  @override
  State<Places2> createState() => _Places2State();
}

class _Places2State extends State<Places2> {
  // SiteStorage _siteData = SiteStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sites')
            .where('isHistoric', isEqualTo: true)
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
