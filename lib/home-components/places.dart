// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:tour_guide_app/Mod/Destinations.dart';

// import 'package:tour_guide_app/Models/Destinations.dart';
// import '../Mod/ReUsableCard.dart';
// import '../widgets/ReUsableCard.dart';

// class Places extends StatefulWidget {
//   const Places({super.key});

//   @override
//   State<Places> createState() => _PlacesState();
// }

// class _PlacesState extends State<Places> {
//   PreviewSite2 _siteData = PreviewSite2();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           // Container(
//           //   width: 20,
//           //   margin: const EdgeInsets.only(
//           //       bottom: 10, top: 20, left: 30, right: 150),
//           //   alignment: Alignment.center,
//           //   child: DefaultTextStyle(
//           //       style: const TextStyle(
//           //           fontStyle: FontStyle.italic,
//           //           color: Colors.white,
//           //           fontSize: 30,
//           //           fontWeight: FontWeight.bold),
//           //       child: AnimatedTextKit(
//           //         animatedTexts: [
//           //           TyperAnimatedText("Where do you want to go ?",
//           //               speed: Duration(milliseconds: 100)),
//           //         ],
//           //       )),
//           // ),
//           // Container(
//           //     decoration: const BoxDecoration(
//           //         color: Colors.white,
//           //         borderRadius: BorderRadius.all(Radius.circular(50))),
//           //     margin: const EdgeInsets.all(20),
//           //     child: TextFormField(
//           //       decoration: const InputDecoration(
//           //         hintStyle: TextStyle(color: Colors.black),
//           //         hintText: "Search for place",
//           //         suffixIcon: Icon(
//           //           size: 30,
//           //           Icons.search,
//           //           color: Colors.black,
//           //         ),
//           //         border: OutlineInputBorder(
//           //             borderRadius: BorderRadius.all(Radius.circular(25.0))),
//           //       ),
//           //     )),
//           ReUsableCard(
//             siteData: _siteData,
//             siteName: "Dead sea",
//           ),
//            ReUsableCard(
//             siteData: _siteData,
//             siteName: "Aqaba",
//           ),
//            ReUsableCard(
//             siteData: _siteData,
//             siteName: "Jarash",
//           ),
//            ReUsableCard(
//             siteData: _siteData,
//             siteName: "Patra",
//           ),
        
//         ],
//       ),
//     );
//   }
// }
