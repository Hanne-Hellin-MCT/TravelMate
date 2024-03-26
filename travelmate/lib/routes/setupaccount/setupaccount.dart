import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetupAccount extends StatefulWidget {
  const SetupAccount({Key? key}) : super(key: key);

  @override
  State<SetupAccount> createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  double _progressValue = 1.0; // Voortgangswaarde tussen 0 en 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LinearProgressIndicator(
            //hoogte van de voortgangsbalk
            minHeight: 15.0,
            //hoeken afronden
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            value: _progressValue, // Voortgangswaarde
            backgroundColor: Colors.white, // Achtergrondkleur
            valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFBB03B)), // Voortgangskleur
          ),
          const Expanded(
            child: Center(
              child: Text("Hello World!"),
            ),
          ),
        ],
      ),
    );
  }
}
