import 'package:flutter/material.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SetupAccountBirthdate extends StatefulWidget {
  const SetupAccountBirthdate({
    super.key,
  });

  @override
  State<SetupAccountBirthdate> createState() => _SetupAccountBirthdateState();
}

class _SetupAccountBirthdateState extends State<SetupAccountBirthdate> {
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Haal de geboortedatum op als een string uit de provider
    String? birthdateString =
        Provider.of<SetupAccountData>(context, listen: false).birthdate;
    // Converteer de string naar een DateTime object
    _selectedDate = _parseBirthdate(birthdateString);
    // Stel de controller in met de geconverteerde datum
    _dateController.text = _selectedDate != null
        ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
        : 'Selecteer een datum';
  }

  DateTime? _parseBirthdate(String? birthdateString) {
    if (birthdateString != null) {
      try {
        return DateFormat('dd-MM-yyyy').parse(birthdateString);
      } catch (e) {
        print('Fout bij het parseren van geboortedatum: $e');
      }
    }
    return null;
  }

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
      String formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      // Stel de geformatteerde datum in op de provider
      // ignore: use_build_context_synchronously
      context.read<SetupAccountData>().setBirthdate(formattedDate);
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF7F6F0),
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, side: BorderSide.none),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedDate != null
                        ? const Color(0xFFFBB03B)
                        : Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
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
      ],
    );
  }
}
