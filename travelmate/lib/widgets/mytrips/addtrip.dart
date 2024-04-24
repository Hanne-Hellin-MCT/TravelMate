import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/addtripprovider.dart';
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

  void _submitData() {
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

    // Navigeer terug naar de overzichtspagina
    Navigator.push(context, MaterialPageRoute(builder: (_) => MyTrips()));
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
