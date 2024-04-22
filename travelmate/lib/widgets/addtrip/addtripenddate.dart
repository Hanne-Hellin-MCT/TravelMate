import 'package:flutter/material.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:travelmate/provider/addtripprovider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddTripEndDate extends StatefulWidget {
  const AddTripEndDate({
    super.key,
  });

  @override
  State<AddTripEndDate> createState() => _AddTripEndDateState();
}

class _AddTripEndDateState extends State<AddTripEndDate> {
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Haal de geboortedatum op als een string uit de provider
    String? EndDateString =
        Provider.of<AddTripData>(context, listen: false).enddate;
    // Converteer de string naar een DateTime object
    _selectedDate = _parsedate(EndDateString);
    // Stel de controller in met de geconverteerde datum
    _dateController.text = _selectedDate != null
        ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
        : 'Selecteer een datum';
  }

  DateTime? _parsedate(String? EndDateString) {
    if (EndDateString != null) {
      try {
        return DateFormat('dd-MM-yyyy').parse(EndDateString);
      } catch (e) {
        print('Fout bij het parseren van geboortedatum: $e');
      }
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    // haal data uit de provider

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      String formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      //check of de einddatum na de startdatum is
      if (Provider.of<AddTripData>(context, listen: false).startdate != null) {
        DateTime? startdate = DateFormat('dd-MM-yyyy')
            .parse(Provider.of<AddTripData>(context, listen: false).startdate!);
        if (picked.isBefore(startdate)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Einddatum moet na de startdatum zijn'),
            ),
          );
          return;
        }
      }
      // Stel de geformatteerde datum in op de provider
      // ignore: use_build_context_synchronously
      context.read<AddTripData>().setEnddate(formattedDate);
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
                  text: 'Wat is de  ',
                ),
                TextSpan(
                  text: 'einddatum ',
                  style: TextStyle(
                    color: Color(0xFFFBB03B), // Gele kleur
                  ),
                ),
                TextSpan(
                  text: 'van je trip?',
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
