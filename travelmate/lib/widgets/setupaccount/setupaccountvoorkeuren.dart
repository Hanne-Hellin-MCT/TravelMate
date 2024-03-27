import 'package:flutter/material.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:provider/provider.dart';

class SetupAccountVoorkeuren extends StatefulWidget {
  const SetupAccountVoorkeuren({
    super.key,
  });

  @override
  State<SetupAccountVoorkeuren> createState() => _SetupAccountVoorkeurenState();
}

class _SetupAccountVoorkeurenState extends State<SetupAccountVoorkeuren> {
  final List<String> gender = [
    'Man',
    'Vrouw',
    'Iedereen',
  ];

  final List<String> afstand = [
    'Vlaanderen',
    'België',
    'Benelux',
    'Europa',
    'Wereldwijd'
  ];

  String selectedAfstand = '';

// De begin- en eindwaarden van de slider
  double _startValue = 18;
  double _endValue = 25;

// Functie om de waarden van de slider bij te werken
  void _updateValues(double startValue, double endValue) {
    //update in provider
    context.read<SetupAccountData>().setLeeftijdvoorkeur(
        '$_startValue - $_endValue'); // Update de waarden in de provider
    setState(() {
      _startValue = startValue;
      _endValue = endValue;
    });
  }

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
                  text: 'Van wie wil jij plannen zien? ',
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Gender:',
            style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Wrap(
            spacing: 10.0,
            children: gender.map((gender) {
              return ChoiceChip(
                label: Text(gender),
                selected: context
                    .watch<SetupAccountData>()
                    .gendervoorkeur
                    .contains(gender),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      context
                          .read<SetupAccountData>()
                          .setGendervoorkeur(gender);
                    } else {
                      context.read<SetupAccountData>().setGendervoorkeur('');
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xFFFBB03B),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: const Color(0xFFF7F6F0),
                selectedColor: const Color(0xFFFBB03B),
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: context
                          .watch<SetupAccountData>()
                          .gendervoorkeur
                          .contains(gender)
                      ? Colors.white
                      : Colors.black,
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
          child: Divider(
            color: Color(0xFFFBB03B),
            thickness: 2,
            height: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Leeftijd:',
                    style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    ' ${_startValue.toStringAsFixed(_startValue.truncateToDouble() == _startValue ? 0 : 2)} - ${_endValue.toStringAsFixed(_endValue.truncateToDouble() == _endValue ? 0 : 2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B6B6B),
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFFFBB03B),
                  inactiveTrackColor: Colors.grey,
                  thumbColor: const Color(0xFFFBB03B),
                  overlayColor: const Color(0xFFFBB03B)
                      .withAlpha(32), // Kleur van het overlayeffect
                  valueIndicatorColor: const Color(
                      0xFFFBB03B), // Kleur van het waarde-indicatorlabel
                  // En andere eigenschappen zoals:
                  // thumbShape, overlayShape, tickMarkShape, valueIndicatorShape, etc.
                ),
                child: RangeSlider(
                  values: RangeValues(_startValue, _endValue),
                  onChanged: (RangeValues values) {
                    _updateValues(values.start, values.end);
                  },
                  min: 18,
                  max: 100,
                  divisions:
                      82, // Aantal tussenliggende waarden (100 - 18 = 82)
                  labels: RangeLabels(
                    _startValue.toStringAsFixed(0),
                    _endValue.toStringAsFixed(0),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
          child: Divider(
            color: Color(0xFFFBB03B),
            thickness: 2,
            height: 10,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Afstand:',
            style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: afstand.map((afstand) {
              return ChoiceChip(
                label: Text(afstand),
                selected: context
                    .watch<SetupAccountData>()
                    .afstandvoorkeur
                    .contains(afstand),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      context
                          .read<SetupAccountData>()
                          .setAfstandvoorkeur(afstand);
                    } else {
                      context.read<SetupAccountData>().setAfstandvoorkeur('');
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xFFFBB03B),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: const Color(0xFFF7F6F0),
                selectedColor: const Color(0xFFFBB03B),
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: context
                          .watch<SetupAccountData>()
                          .afstandvoorkeur
                          .contains(afstand)
                      ? Colors.white
                      : Colors.black,
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
