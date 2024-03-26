import 'package:flutter/material.dart';

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

  String selectedGender = '';

// De begin- en eindwaarden van de slider
  double _startValue = 18.0;
  double _endValue = 25.0;

// Functie om de waarden van de slider bij te werken
  void _updateValues(double startValue, double endValue) {
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
            spacing: 10.0, // Ruimte tussen de chips
            runSpacing: 10.0, // Ruimte tussen de rijen
            children: gender
                .map(
                  (gender) => ChoiceChip(
                    label: Text(gender),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0), // Aangepaste interne padding
                    selected: selectedGender.contains(gender),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGender = gender;
                        } else {
                          selectedGender = '';
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color(
                            0xFFFBB03B), // Geen randkleur als niet geselecteerd
                        width: 2.0, // Dikte van de rand
                      ),
                      borderRadius: BorderRadius.circular(
                          10.0), // Borderradius van de chip
                    ),
                    backgroundColor: const Color(0xFFF7F6F0),
                    selectedColor: const Color(0xFFFBB03B),
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: selectedGender.contains(gender)
                          ? Colors.white // Witte tekst als geselecteerd
                          : Colors.black,
                      // Zwarte tekst als niet geselecteerd
                    ),
                    showCheckmark: false, // Verberg het selectievinkje
                  ),
                )
                .toList(),
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
                    ' $_startValue - $_endValue', // Dynamisch tekstgedeelte met de geselecteerde waarden
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B6B6B),
                    ),
                  ),
                ],
              ),
              // Hier plaats je de SliderTheme met de RangeSlider
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
                  min: 18.0,
                  max: 100.0,
                  divisions:
                      82, // Aantal tussenliggende waarden (100 - 18 = 82)
                  labels: RangeLabels(
                      '$_startValue', '$_endValue'), // Labels voor de waarden
                ),
              ),
            ],
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
