import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelmate/routes/auth/credentials.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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

  void signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Credentials(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SetupAccountData>(context, listen: false);
    double startValue = provider.getMinLeeftijdvoorkeur()?.toDouble() ?? 18;
    double endValue = provider.getMaxLeeftijdvoorkeur()?.toDouble() ?? 100;

    void _updateValues(double startValue, double endValue) {
      //update in provider
      context.read<SetupAccountData>().setLeeftijdvoorkeur(
          '$startValue - $endValue'); // Update de waarden in de provider
      setState(() {
        startValue = startValue;
        endValue = endValue;
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profilePicture(provider.getFotosurls()),
                //haal naam uit provider
                Text('${provider.getName()}',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Text(
            //       'Gender:',
            //       style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            //       child: Wrap(
            //         spacing: 10.0,
            //         children: gender.map((gender) {
            //           return ChoiceChip(
            //             label: Text(gender),
            //             selected: provider.getGendervoorkeur().contains(gender),
            //             onSelected: (selected) {
            //               setState(() {
            //                 provider.setGendervoorkeur(gender);
            //                 // TODO: update in database
            //               });
            //             },
            //             shape: RoundedRectangleBorder(
            //               side: const BorderSide(
            //                 color: Color(0xFFFBB03B),
            //                 width: 2.0,
            //               ),
            //               borderRadius: BorderRadius.circular(10.0),
            //             ),
            //             backgroundColor: const Color(0xFFF7F6F0),
            //             selectedColor: const Color(0xFFFBB03B),
            //             labelStyle: TextStyle(
            //               fontSize: 16,
            //               color: provider.getGendervoorkeur().contains(gender)
            //                   ? Colors.white
            //                   : Colors.black,
            //             ),
            //             showCheckmark: false,
            //           );
            //         }).toList(),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         top: 20,
            //       ),
            //       child: Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               const Text(
            //                 'Leeftijd:',
            //                 style: TextStyle(
            //                     fontSize: 20, color: Color(0xFF000000)),
            //                 textAlign: TextAlign.start,
            //               ),
            //               Text(
            //                 ' ${startValue.toStringAsFixed(startValue.truncateToDouble() == startValue ? 0 : 2)} - ${endValue.toStringAsFixed(endValue.truncateToDouble() == endValue ? 0 : 2)}',
            //                 style: const TextStyle(
            //                   fontSize: 16,
            //                   color: Color(0xFF6B6B6B),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SliderTheme(
            //             data: SliderTheme.of(context).copyWith(
            //               activeTrackColor: const Color(0xFFFBB03B),
            //               inactiveTrackColor: Colors.grey,
            //               thumbColor: const Color(0xFFFBB03B),
            //               overlayColor: const Color(0xFFFBB03B)
            //                   .withAlpha(32), // Kleur van het overlayeffect
            //               valueIndicatorColor: const Color(
            //                   0xFFFBB03B), // Kleur van het waarde-indicatorlabel
            //               // En andere eigenschappen zoals:
            //               // thumbShape, overlayShape, tickMarkShape, valueIndicatorShape, etc.
            //             ),
            //             child: RangeSlider(
            //               values: RangeValues(startValue, endValue),
            //               onChanged: (RangeValues values) {
            //                 _updateValues(values.start, values.end);
            //               },
            //               min: 18,
            //               max: 100,
            //               divisions:
            //                   82, // Aantal tussenliggende waarden (100 - 18 = 82)
            //               labels: RangeLabels(
            //                 startValue.toStringAsFixed(0),
            //                 endValue.toStringAsFixed(0),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 20.0),
            //button voor uit te loggen
            ElevatedButton(
              onPressed: () {
                signout();
                print('Sign out');
                // clear provider data
                provider.resetData();
                //show errortext that email is send
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBB03B),
                textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white, // Witte tekstkleur
                ),
                minimumSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Sign out',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profilePicture(List<String> imageUrls) {
  if (imageUrls.isEmpty) {
    // If the list is empty, display a default avatar or an empty container
    return const CircleAvatar(
      backgroundColor: Colors.grey, // Example color
      radius: 80.0,
    );
  } else {
    // Use the first URL from the list
    final firstImageUrl = imageUrls.first;

    return CachedNetworkImage(
      imageUrl: firstImageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: 80.0,
      ),
    );
  }
}
