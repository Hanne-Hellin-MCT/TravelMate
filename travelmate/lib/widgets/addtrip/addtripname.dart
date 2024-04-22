import 'package:flutter/material.dart';
import 'package:travelmate/provider/addtripprovider.dart';
import 'package:provider/provider.dart';

class AddTripName extends StatefulWidget {
  const AddTripName({
    super.key,
  });

  @override
  State<AddTripName> createState() => _AddTripNameState();
}

class _AddTripNameState extends State<AddTripName> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current name
    _nameController = TextEditingController(
        text: Provider.of<AddTripData>(context, listen: false).tripname ?? '');
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _nameController.dispose();
    super.dispose();
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
                  text: 'Geef je trip een ',
                ),
                TextSpan(
                  text: 'Naam',
                  style: TextStyle(
                    color: Color(0xFFFBB03B), // Gele kleur
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Naam van de trip',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBB03B), width: 2.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
              ),
            ),
            controller: _nameController,
            onChanged: (newName) {
              Provider.of<AddTripData>(context, listen: false)
                  .setTripname(newName);
            },
          ),
        ),
      ],
    );
  }
}
