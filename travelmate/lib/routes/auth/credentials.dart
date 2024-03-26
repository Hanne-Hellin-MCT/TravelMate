import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelmate/widgets/signinbuttons.dart';
import 'package:travelmate/widgets/signinwithemail.dart';

class Credentials extends StatefulWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  String email = '';
  String password = '';

  // void login() async {
  //   if (email.isNotEmpty || password.isNotEmpty) {
  //     print('Email: $email');
  //     print('Password: $password');
  //   }
  //   try {
  //     final credential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     if (credential.user != null) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => NoteOverviewNavigation(),
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     } else {
  //       print('Error: $e');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150,
            left: 35,
            child: Center(
                child: Column(
              children: [
                SvgPicture.asset(
                  'lib/assets/logo.svg',
                  width: 250,
                  height: 250,
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Travel',
                      ),
                      TextSpan(
                        text: 'Mate',
                        style: TextStyle(
                          color: Color(0xFFFBB03B), // Gele kleur
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
          ),
          const signinwithemail(),
        ],
      ),
    );
  }
}
