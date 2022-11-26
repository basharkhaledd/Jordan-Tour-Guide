import 'package:flutter/material.dart';
import 'package:tour_guide_app/Firebase_Services/firebase_auth.dart';
import 'package:tour_guide_app/Screens/forgot_passwor.dart';
import 'package:tour_guide_app/Screens/signup_screen.dart';
import 'package:tour_guide_app/home-components/places.dart';
import 'package:tour_guide_app/home-components/places2.dart';
import 'package:tour_guide_app/homepage.dart';
import 'package:tour_guide_app/utils/colors.dart';
import 'package:tour_guide_app/utils/utils.dart';
import 'package:tour_guide_app/widgets/textfieldinput.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .logInUser(email: _email.text, password: _password.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void NavigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //image
              Container(
                height: 80,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/petra.png'),
                  ),
                ),
              ),
              //spacing
              const SizedBox(
                height: 40,
              ),
              //textField For email
              TextFieldInput(
                  textEditingController: _email,
                  hintText: "enter your email",
                  textInputType: TextInputType.emailAddress),
              //spacing
              const SizedBox(
                height: 22,
              ),
              //textField For password
              TextFieldInput(
                textEditingController: _password,
                hintText: "enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              //spacing
              SizedBox(
                height: 22,
              ),
              //log in button
              InkWell(
                onTap: logInUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              //spacing
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPassword()));
                },
                child: const Text("Forgot Password?",
                    style: TextStyle(
                      color: Color(0xff6A707C),
                      fontSize: 15,
                    )),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Dont have an account?',
                    ),
                  ),
                  GestureDetector(
                    onTap: NavigateToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Signup.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
