import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide_app/Firebase_Services/firebase_auth.dart';
import 'package:tour_guide_app/Screens/login_screen.dart';
import 'package:tour_guide_app/home-components/places.dart';
import 'package:tour_guide_app/home-components/places2.dart';
import 'package:tour_guide_app/homepage.dart';
import 'package:tour_guide_app/utils/colors.dart';
import 'package:tour_guide_app/utils/utils.dart';
import 'package:tour_guide_app/widgets/textfieldinput.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _username = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
    _username.dispose();
  }

  // void selectImage() async {
  //   Uint8List im = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = im;
  //   });
  // }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _email.text,
      password: _password.text,
      username: _username.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  void NavigateToLogIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LogInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //image
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
              //spacing
              const SizedBox(
                height: 24,
              ),

              const SizedBox(
                height: 24,
              ),
              //textfield for username
              TextFieldInput(
                  textEditingController: _username,
                  hintText: "enter your username",
                  textInputType: TextInputType.text),
              //spacing
              const SizedBox(
                height: 24,
              ),

              //textField For email
              TextFieldInput(
                  textEditingController: _email,
                  hintText: "enter your email",
                  textInputType: TextInputType.emailAddress),
              //spacing
              const SizedBox(
                height: 24,
              ),
              //textField For password
              TextFieldInput(
                textEditingController: _password,
                hintText: "enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              //spacing
              const SizedBox(
                height: 24,
              ),

              //spacing
              const SizedBox(
                height: 24,
              ),
              //sign up button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Sign up"),
                ),
              ),
              //spacing
              const SizedBox(
                height: 24,
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
                      'already have an account ?',
                    ),
                  ),
                  GestureDetector(
                    onTap: NavigateToLogIn,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Log in.',
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
