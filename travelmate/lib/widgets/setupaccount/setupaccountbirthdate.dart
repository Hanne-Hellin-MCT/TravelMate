import 'package:flutter/material.dart';

class SetupAccountBirthdate extends StatefulWidget {
  const SetupAccountBirthdate({
    super.key,
  });

  @override
  State<SetupAccountBirthdate> createState() => _SetupAccountBirthdateState();
}

class _SetupAccountBirthdateState extends State<SetupAccountBirthdate> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
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
                  text: 'Wat is je ',
                ),
                TextSpan(
                  text: 'Geboortedatum',
                  style: TextStyle(
                    color: Color(0xFFFBB03B), // Gele kleur
                  ),
                ),
                TextSpan(
                  text: '?',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: ElevatedButton(
            onPressed: () => _selectDate(context),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFF7F6F0)),
              elevation: MaterialStateProperty.all<double>(0),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedDate != null
                        ? const Color(0xFFFBB03B)
                        : Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null
                        ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                        : 'Selecteer een datum',
                    style: TextStyle(
                      color: _selectedDate != null
                          ? const Color(0xFFFBB03B)
                          : Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: _selectedDate != null
                        ? const Color(0xFFFBB03B)
                        : Colors.grey,
                  ),
                ],
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
