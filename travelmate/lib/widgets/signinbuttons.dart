import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';

class signinbuttons extends StatelessWidget {
  const signinbuttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50, // Afstand vanaf de onderkant
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // gap

        children: [
          SignInButtonBuilder(
            text: 'Sign in with Email',
            icon: Icons.email,
            onPressed: () {},
            backgroundColor: const Color(0xFFFBB03B),
            width: 300,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(height: 10),
          SignInButtonBuilder(
            text: 'Sign in with Facebook',
            icon: Icons.facebook_outlined,
            onPressed: () {},
            backgroundColor: const Color(0xFFFBB03B),
            width: 300,
            height: 50,
            // text centreren
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(height: 10),
          SignInButtonBuilder(
            text: 'Sign in with Google',
            icon: Icons.facebook_outlined,
            onPressed: () {},
            backgroundColor: const Color(0xFFFBB03B),
            width: 300,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ],
      ),
    );
  }
}
