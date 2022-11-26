import 'package:flutter/material.dart';
import 'package:tour_guide_app/Screens/signup_screen.dart';
import 'package:tour_guide_app/homepage.dart';
import 'package:tour_guide_app/main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatehome();
  }

  navigatehome() async {
    await Future.delayed(
      Duration(milliseconds: 2000),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 57, 43, 43),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 84,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/petra.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome Jordan Tour",
              style: TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 231, 225, 223)),
            ),
          ],
        ),
      ),
    );
  }
}
