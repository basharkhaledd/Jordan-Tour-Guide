// class sites {
//   String title;
//   String description;
//   String siteImage;
//   sites(
//       {required this.title,
//       required this.description,
//       required this.siteImage});
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Sites {
  String description;
  String title;
  String previewimage;
  // String siteImage;
  List imageList;
  double latitude;
  double longitude;

  Sites({
    required this.title,
    required this.previewimage,
    // required this.siteImage,
    this.latitude = 3,
    this.longitude = 3,
    required this.description,
    required this.imageList,
  });

  static Sites fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Sites(
      description: snapshot["description"],
      title: snapshot["title"],
      previewimage: snapshot["previewimage"],
      imageList: snapshot["imageList"],
      // siteImage: ,
      latitude: snapshot["latitude"],
      longitude: snapshot["longitude"],
    );
  }
}
