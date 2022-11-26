import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class verifyemail extends StatefulWidget {
  const verifyemail({super.key});

  @override
  State<verifyemail> createState() => _verifyemailState();
}

class _verifyemailState extends State<verifyemail> {
  bool isEmailVerified = false;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
    }
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("verify your email")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "A verification email has been sent to your email",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.email, size: 32),
              label: Text(
                "Resend Email",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: sendVerificationEmail,
            ),
            SizedBox(height: 24),
            TextButton(
                style:
                    ElevatedButton.styleFrom(maximumSize: Size.fromHeight(50)),
                child: Text("Cancel", style: TextStyle(fontSize: 24)),
                onPressed: (() => FirebaseAuth.instance.signOut()))
          ],
        ),
      ),
    );
  }
}
