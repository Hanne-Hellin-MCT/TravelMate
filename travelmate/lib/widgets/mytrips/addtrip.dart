import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/AddTripProvider.dart';
import 'package:travelmate/widgets/addtrip/addtripname.dart';

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
      // AddTripDates(),
      // AddTripFeatures(),
      // AddTripDescription(),
      // AddTripPhotos(),
      // AddTripPreferences(),
    ];
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < _setupSteps.length - 1) {
        _currentStep++;
      } else {
        // Handle save action when all steps are completed
        _saveData();
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  void _saveData() {
    // Implement logic to save trip data
    // This could involve sending data to a database or performing local storage
    // After saving, you might navigate back or display a success message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / _setupSteps.length,
          ),
          Expanded(
            child: _setupSteps[_currentStep],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  ElevatedButton(
                    onPressed: _previousStep,
                    child: Text('Previous'),
                  ),
                ElevatedButton(
                  onPressed: _nextStep,
                  child: Text(
                      _currentStep == _setupSteps.length - 1 ? 'Save' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
