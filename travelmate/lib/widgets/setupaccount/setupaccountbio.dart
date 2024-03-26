import 'package:flutter/material.dart';

class SetupAccountBio extends StatelessWidget {
  const SetupAccountBio({
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
                  text: 'bio ',
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
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: TextField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Schrijf iets',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBB03B), width: 2.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7F6F0),
                side: const BorderSide(color: Color(0xFFFBB03B), width: 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                width: double.infinity, // Volledige breedte
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0), // Aangepaste padding
                child: const Text(
                  'Volgende',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center, // Tekst centreren binnen de knop
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
