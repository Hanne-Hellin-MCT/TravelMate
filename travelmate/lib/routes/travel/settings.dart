import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
              ],
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
