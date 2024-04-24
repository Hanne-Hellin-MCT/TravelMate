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
  List<Map> account = [
    {
      'name': 'John Doe',
      'PhotoUrl':
          'https://reneeroaming.com/wp-content/uploads/2020/10/What-to-wear-hiking-as-a-woman-cute-hiking-boots-for-women-819x1024.jpg',
      'Leeftijdbeginvoorkeur': 18,
      'Leeftijdeindvoorkeur': 20,
      'Geslachtvoorkeur': 'Man',
      'Afstandvoorkeur': 100,
    },
  ];

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

  void _updateValues(double startValue, double endValue) {
    //update in provider
    // context.read<SetupAccountData>().setLeeftijdvoorkeur(
    //     '$_startValue - $_endValue'); // Update de waarden in de provider
    setState(() {
      _startValue = startValue;
      _endValue = endValue;
    });
  }

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profilePicture(account[0]['PhotoUrl'] ??
                    'https://via.placeholder.com/150'),
                Text('${account[0]['name']}',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gender:',
                  style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Wrap(
                    spacing: 10.0,
                    children: gender.map((gender) {
                      return ChoiceChip(
                        label: Text(gender),
                        selected:
                            account[0]['Geslachtvoorkeur'].contains(gender),
                        onSelected: (selected) {
                          setState(() {});
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
                          color: account[0]['Geslachtvoorkeur'].contains(gender)
                              ? Colors.white
                              : Colors.black,
                        ),
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Leeftijd:',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFF000000)),
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
              ],
            ),
            const SizedBox(height: 20.0),
            //button voor uit te loggen
            ElevatedButton(
              onPressed: () {
                signout();
                print('Sign out');
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

Widget profilePicture(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
    imageBuilder: (context, imageProvider) => CircleAvatar(
      backgroundImage: imageProvider,
      radius: 80.0,
    ),
  );
}
