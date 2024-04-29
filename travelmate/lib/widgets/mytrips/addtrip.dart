import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/addtripprovider.dart';
import 'package:travelmate/routes/setupaccount/setupaccount.dart';
import 'package:travelmate/routes/travel/mytrips.dart';
import 'package:travelmate/widgets/addtrip/addtripenddate.dart';
import 'package:travelmate/widgets/addtrip/addtripstartdate.dart';
import 'package:travelmate/widgets/addtrip/addtripname.dart';
import 'package:travelmate/widgets/mytrips/mytripsoverview.dart';
import 'package:travelmate/widgets/addtrip/addtripfeatures.dart';
import 'package:travelmate/widgets/addtrip/addtripdescription.dart';
import 'package:travelmate/widgets/addtrip/addtripphoto.dart';
import 'package:travelmate/widgets/addtrip/addtripvoorkeuren.dart';
import 'package:travelmate/routes/travel/travelnavigationbar.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:http/http.dart' as http;

class AddTrip extends StatefulWidget {
  const AddTrip({Key? key}) : super(key: key);

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  int _currentStep = 0;
  List<Widget> _setupSteps = [];

  @override
  void initState() {
    super.initState();
    _setupSteps = [
      AddTripName(),
      AddTripStartDate(),
      AddTripEndDate(),
      AddTripFeatures(),
      AddTripDescription(),
      AddTripPhoto(),
      AddTripPreferences(),
    ];
  }

  double _progressValue = 0.1;
  void _nextStep() {
    setState(() {
      if (_currentStep < _setupSteps.length - 1) {
        _currentStep++;
        _progressValue = (_currentStep + 1) / _setupSteps.length;
      } else {
        _submitData();
      }
    });
  }

  void _submitData() async {
    // print alle data uit de provider
    print(Provider.of<AddTripData>(context, listen: false).tripname);
    print(Provider.of<AddTripData>(context, listen: false).startdate);
    print(Provider.of<AddTripData>(context, listen: false).enddate);
    print(Provider.of<AddTripData>(context, listen: false).features);
    print(Provider.of<AddTripData>(context, listen: false).description);
    print(Provider.of<AddTripData>(context, listen: false).tripname);
    print(Provider.of<AddTripData>(context, listen: false).leeftijdvoorkeur);
    print(Provider.of<AddTripData>(context, listen: false).gendervoorkeur);
    print(Provider.of<AddTripData>(context, listen: false).afstandvoorkeur);
    print(Provider.of<AddTripData>(context, listen: false).imageUrl);

    // Voeg de trip toe aan de database

    try {
      // Voeg de trip toe aan de database
      final url = 'http://10.0.2.2:5092/trips/';
      // Maak een POST request naar de backend
      // make featureslist readable for backend

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'Destination':
              Provider.of<AddTripData>(context, listen: false).tripname,
          'name': Provider.of<AddTripData>(context, listen: false).tripname,
          'EndDate': Provider.of<AddTripData>(context, listen: false)
              .enddate
              .toIso8601String(),
          'StartDate': Provider.of<AddTripData>(context, listen: false)
              .startdate
              .toIso8601String(),
          'Features': Provider.of<AddTripData>(context, listen: false).features,
          'Description':
              Provider.of<AddTripData>(context, listen: false).description,
          'FotosURL': Provider.of<AddTripData>(context, listen: false).imageUrl,
          'Voorkeursleeftijd':
              Provider.of<AddTripData>(context, listen: false).leeftijdvoorkeur,
          'Voorkeursgender':
              Provider.of<AddTripData>(context, listen: false).gendervoorkeur,
          'TravelerId':
              Provider.of<SetupAccountData>(context, listen: false).getIdToken()
        }),
      );

      if (response.statusCode == 200) {
        print('Trip added successfully');
        Provider.of<AddTripData>(context, listen: false).resetData();
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => TravelMateNavigation()));
      } else {
        print('Error adding trip: ${response.statusCode}');
        print(response.body);
      }

      // Gebruik de data uit de provider om de trip toe te voegen
    } catch (e) {
      // Vang eventuele fouten op
      print('Error adding trip: $e');
      print('Failed to add trip');
    }

    // Navigeer terug naar de overzichtspagina
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
        _progressValue = _currentStep / (_setupSteps.length - 1);
      } else {
        // Handle the case when _currentStep is already at its minimum value
        // For example, you can navigate back to the previous screen
        Navigator.pop(context);
      }
    });
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
                TextButton(
                  onPressed: () {
                    if (_currentStep > 0) {
                      _previousStep();
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TravelMateNavigation()));
                    }
                  },
                  child: const Text(
                    'Terug',
                    style: TextStyle(fontSize: 20, color: Color(0xFFFBB03B)),
                  ),
                ),
              ],
            ),
          ),

          _setupSteps[_currentStep],
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed:
                    _nextStep, // Veranderde onPressed om naar de volgende stap te gaan
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
