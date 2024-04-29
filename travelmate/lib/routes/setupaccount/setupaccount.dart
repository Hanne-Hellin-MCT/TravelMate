import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelmate/widgets/setupaccount/setupaccountname.dart';
import 'package:travelmate/widgets/setupaccount/setupaccountbirthdate.dart';
import 'package:travelmate/widgets/setupaccount/setupaccountgender.dart';
import 'package:travelmate/widgets/setupaccount/setupaccountinterests.dart';
import 'package:travelmate/widgets/setupaccount/setupaccountphotos.dart';
import 'package:travelmate/widgets/setupaccount/setupaccountbio.dart';
import 'package:travelmate/widgets/setupaccount/setupaccountvoorkeuren.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/routes/travel/travelnavigationbar.dart';
import 'package:http/http.dart' as http;

class SetupAccount extends StatefulWidget {
  const SetupAccount({Key? key}) : super(key: key);

  @override
  State<SetupAccount> createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  int _currentStep = 0; // Huidige stap van de setup
  final List<Widget> _setupSteps = [
    SetupAccountName(),
    SetupAccountBirthdate(),
    SetupAccountGender(),
    SetupAccountInterests(),
    SetupAccountPhotos(),
    SetupAccountBio(),
    SetupAccountVoorkeuren(),
  ];
  double _progressValue = 0.0; // Voortgangswaarde tussen 0 en 1

  void _nextStep() {
    setState(() {
      if (_currentStep < _setupSteps.length - 1) {
        _currentStep++;
        _progressValue = (_currentStep + 1) / _setupSteps.length;
      } else {
        final String name = context.read<SetupAccountData>().name;
        final String gender = context.read<SetupAccountData>().gender;
        final DateTime birthdate = context.read<SetupAccountData>().birthdate;
        final String bio = context.read<SetupAccountData>().bio;
        final List<String> interests =
            context.read<SetupAccountData>().interests;
        final List<String> voorkeuren =
            context.read<SetupAccountData>().getVoorkeuren();
        print('naam: $name');
        print('id token: ${context.read<SetupAccountData>().idtoken}');
        print('geslacht: $gender');
        print('birthdate: $birthdate');
        print('fotos: ${context.read<SetupAccountData>().fotosurls}');
        print('bio: $bio');
        print('interests: $interests');
        print('voorkeuren: $voorkeuren');

        _submitData();
      }
    });
  }

  void _submitData() async {
    // Verstuur de data naar de server

    // push naar backend
    final url = 'http://10.0.2.2:5092/travelers';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'Id': context.read<SetupAccountData>().idtoken,
          'Name': context.read<SetupAccountData>().name,
          'Birthdate':
              context.read<SetupAccountData>().birthdate.toIso8601String(),
          'Gender': context.read<SetupAccountData>().gender,
          'Bio': context.read<SetupAccountData>().bio,
          'PhotoUrls': context.read<SetupAccountData>().fotosurls,
          'Features': context.read<SetupAccountData>().interests,
          'PreferredGender': context.read<SetupAccountData>().gendervoorkeur,
          'PreferredDistance': context.read<SetupAccountData>().afstandvoorkeur,
          'PreferredMinAge': 18,
          'PreferredMaxAge': 25,
        },
      ),
    );

    // repsone
    if (response.statusCode == 200) {
      print('Data succesvol naar de server gestuurd');
      print(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TravelMateNavigation(),
        ),
      );
    } else {
      print(
          'Fout bij het verzenden van data naar de server: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            //hoogte van de voortgangsbalk
            minHeight: 15.0,
            //hoeken afronden
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            value: _progressValue, // Voortgangswaarde
            backgroundColor: const Color(0xFFF7F6F0), // Achtergrondkleur
            valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFBB03B)), // Voortgangskleur
          ),
          // terugknop
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 0, bottom: 0),
            child: Column(
              children: [
                Visibility(
                  visible:
                      _currentStep > 0, // Alleen zichtbaar als currentStep > 0
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (_currentStep > 0) {
                          _currentStep--; // Stap terug
                          _progressValue =
                              _currentStep / (_setupSteps.length - 1);
                        }
                      });
                    },
                    child: const Text(
                      'Terug',
                      style: TextStyle(fontSize: 20, color: Color(0xFFFBB03B)),
                    ),
                  ),
                )
              ],
            ),
          ),

          _setupSteps[_currentStep],
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _nextStep,
                // Veranderde onPressed om naar de volgende stap te gaan
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: Color(0xFFFBB03B), width: 2.0), // Rand
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Afgeronde hoeken
                  ),
                ),

                child: Container(
                  width: double.infinity, // Volledige breedte
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0), // Aangepaste padding
                  child: Text(
                    _currentStep == _setupSteps.length - 1
                        ? 'Opslaan'
                        : 'Volgende', // Tekst van de knop
                    textAlign:
                        TextAlign.center, // Tekst centreren binnen de knop
                    style: const TextStyle(
                        fontSize: 20, color: Color(0xFF000000) // Tekstgrootte
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
