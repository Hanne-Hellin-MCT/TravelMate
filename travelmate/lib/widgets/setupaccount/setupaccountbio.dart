import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:provider/provider.dart';

class SetupAccountBio extends StatefulWidget {
  const SetupAccountBio({
    super.key,
  });

  @override
  State<SetupAccountBio> createState() => _SetupAccountBioState();
}

class _SetupAccountBioState extends State<SetupAccountBio> {
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    // Initialiseer de controller met de huidige bio uit de provider
    _bioController = TextEditingController(
        text: Provider.of<SetupAccountData>(context, listen: false).bio);
  }

  @override
  void dispose() {
    // Verwijder de controller om geheugenlekken te voorkomen
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentBio = Provider.of<SetupAccountData>(context).bio ?? '';

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
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: TextField(
              controller: _bioController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: currentBio.isNotEmpty ? currentBio : 'Schrijf iets',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFBB03B), width: 2.0),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
                ),
              ),
              onChanged: (newBio) {
                Provider.of<SetupAccountData>(context, listen: false)
                    .setBio(newBio);
              }),
        ),
      ],
    );
  }
}
