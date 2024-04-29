import 'package:flutter/material.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:provider/provider.dart';

class SetupAccountName extends StatefulWidget {
  const SetupAccountName({
    super.key,
  });

  @override
  State<SetupAccountName> createState() => _SetupAccountNameState();
}

class _SetupAccountNameState extends State<SetupAccountName> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Maak de controller aan en stel de initiële waarde in
    _nameController = TextEditingController(
        text: Provider.of<SetupAccountData>(context, listen: false).name ?? '');
  }

  @override
  void dispose() {
    // Zorg ervoor dat de controller wordt opgeruimd wanneer de widget wordt verwijderd
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
                  text: 'Wat is je ',
                ),
                TextSpan(
                  text: 'Voornaam',
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
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Vul je voornaam in',
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
            controller:
                _nameController, // Gebruik de geconfigureerde controller
            onChanged: (newName) {
              Provider.of<SetupAccountData>(context, listen: false)
                  .setName(newName);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: RichText(
            textAlign: TextAlign.start,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B6B6B),
              ),
              children: [
                TextSpan(
                  text: 'Dit is hoe het op je profiel zal verschijnen\n',
                ),
                TextSpan(
                  text: 'Je kan dit later niet meer aanpassen.',
                  style: TextStyle(
                    //bold
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class _SetupAccountNameState extends State<SetupAccountName> {
//   @override
//   Widget build(BuildContext context) {
//     String currentName = Provider.of<SetupAccountData>(context).name ?? '';

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 50, left: 20),
//           child: RichText(
//             textAlign: TextAlign.start,
//             text: const TextSpan(
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF000000),
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Wat is je ',
//                 ),
//                 TextSpan(
//                   text: 'Voornaam',
//                   style: TextStyle(
//                     color: Color(0xFFFBB03B), // Gele kleur
//                   ),
//                 ),
//                 TextSpan(
//                   text: '?',
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
//           child: TextField(
//             decoration: const InputDecoration(
//               hintText: 'Vul je voornaam in',
//               hintStyle: TextStyle(
//                 color: Colors.grey,
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xFFFBB03B), width: 2.0),
//               ),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
//               ),
//               border: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xFFFBB03B), width: 1.0),
//               ),
//             ),
//             controller: TextEditingController(text: currentName),
//             onChanged: (newName) {
//               Provider.of<SetupAccountData>(context, listen: false)
//                   .setName(newName);
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 30, left: 20),
//           child: RichText(
//             textAlign: TextAlign.start,
//             text: const TextSpan(
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFF6B6B6B),
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Dit is hoe het op je profiel zal verschijnen\n',
//                 ),
//                 TextSpan(
//                   text: 'Je kan dit later niet meer aanpassen.',
//                   style: TextStyle(
//                     //bold
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
