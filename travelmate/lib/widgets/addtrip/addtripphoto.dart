import 'package:flutter/material.dart';

class AddTripPhoto extends StatelessWidget {
  const AddTripPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 20),
          child: RichText(
            textAlign: TextAlign.start,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
              children: [
                TextSpan(
                  text: 'Voeg een ',
                ),
                TextSpan(
                  text: 'foto ',
                  style: TextStyle(
                    color: Color(0xFFFBB03B), // Gele kleur
                  ),
                ),
                TextSpan(
                  text: 'toe',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              //afgeronde hoeken
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFFFBB03B), // Gele randkleur
                width: 3,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.add, // Pluspictogram
                size: 200 / 2, // Grootte van het pluspictogram
                color: Color(0xFFFBB03B), // Gele pluskleur
              ),
            ),
          ),
        ),
      ],
    );
  }
}