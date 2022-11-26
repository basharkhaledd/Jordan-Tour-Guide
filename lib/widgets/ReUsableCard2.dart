import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide_app/Screens/LoadingScreen.dart';
import '../Screens/ViewDestinationPage.dart';

class ReUsableCard2 extends StatefulWidget {
  ReUsableCard2({
    Key? key,
    required this.snap,
    required this.siteName,
  }) : super(key: key);

  final snap;
  final String siteName;

  @override
  State<ReUsableCard2> createState() => _ReUsableCard2State();
}

class _ReUsableCard2State extends State<ReUsableCard2> {
  String governate = '';

  // @override
  // void initState() {
  //   super.initState();
  //   getGovernate();
  // }

  // void getGovernate() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('sites')
  //       .doc(' ${widget.snap['title']}')
  //       .get();

  //   setState(() {
  //     governate = (snap.data() as Map<String, dynamic>)['governorates'];
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 200,
      child: GestureDetector(
        onTap: () {
          print(widget.snap['description']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoadingScreen(
                  siteName: ' ${widget.snap['title']}'.trim(),
                  governorate: ' ${widget.snap['governorates']}'),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.snap['previewimage'].toString(),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  title: Text(
                    ' ${widget.snap['title']}',
                    // _siteData.getSiteTitle(siteName: siteName),
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    ' ${widget.snap['governorates']}',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
