import 'package:flutter/material.dart';

import 'package:tour_guide_app/Screens/signup_screen.dart';

import '../widgets/customized_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://tourscanner.com/blog/wp-content/uploads/2022/07/things-to-do-in-Amman-Jordan-.jpg"),
                fit: BoxFit.cover)),
        child: Container(
          margin: EdgeInsets.only(top: 400),
          child: Column(
            children: [
              CustomizedButton(
                buttonText: "Login",
                buttonColor: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LogInScreen()));
                },
              ),
              CustomizedButton(
                buttonText: "Register",
                buttonColor: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
