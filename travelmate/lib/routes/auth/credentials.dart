import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelmate/routes/travel/travelnavigationbar.dart';
import 'package:travelmate/widgets/signinbuttons.dart';
import 'package:travelmate/widgets/signinwithemail.dart';
import 'package:travelmate/widgets/forgetpassword.dart';

class Credentials extends StatefulWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
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
