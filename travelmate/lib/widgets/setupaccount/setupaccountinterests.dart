import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SetupAccountInterests extends StatefulWidget {
  const SetupAccountInterests({
    super.key,
  });

  @override
  State<SetupAccountInterests> createState() => _SetupAccountInterestsState();
}

class _SetupAccountInterestsState extends State<SetupAccountInterests> {
  List<String> interests1 = [
    'Avontuurlijk',
    'Citytrip',
    'Hiking',
    'Rondreis',
    'Camping',
    'Backpacking',
    'Wintersport',
    'Platteland',
  ];

  List<String> interests2 = [
    'Camping',
    'Hotel',
    'Hostel',
    'Appartement',
    'Vakantiehuis',
    'Bed & Breakfast',
    'Glamping',
  ];

  List<Map> fetchdata = []; // Initialize data as an empty list

  // Function to fetch data from API
  Future<void> fetchData() async {
    final url =
        'http://10.0.2.2:5092/features'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          // Update the data list with the fetched data
          fetchdata =
              jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
        });
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the fetchData function when the state is initialized
    fetchData().then((_) {
      // This code will execute after fetchData completes
      print("fetchdata");
      print(fetchdata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
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
                text: 'Wat zijn je ',
              ),
              TextSpan(
                text: 'Interesses',
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
      Container(
        height: 600,
        child: SingleChildScrollView(
          child: Wrap(
            children: fetchdata
                .map((item) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                  '${item['svgPath']}',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Text(
                                '${item['vraag']}',
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF000000)),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Wrap(
                            spacing: 10.0, // Ruimte tussen de chips
                            runSpacing: 10.0, // Ruimte tussen de rijen
                            children: (item['opties'] as List<dynamic>)
                                .map(
                                  (interest) => ChoiceChip(
                                    label: Text(interest),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical:
                                            4.0), // Aangepaste interne padding
                                    selected: context
                                        .read<SetupAccountData>()
                                        .interests
                                        .contains(interest),
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          context
                                              .read<SetupAccountData>()
                                              .addInterest(interest);
                                        } else {
                                          context
                                              .read<SetupAccountData>()
                                              .removeInterest(interest);
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
                                      color: context
                                              .read<SetupAccountData>()
                                              .interests
                                              .contains(interest)
                                          ? Colors
                                              .white // Witte tekst als geselecteerd
                                          : Colors.black,
                                      // Zwarte tekst als niet geselecteerd
                                    ),
                                    showCheckmark:
                                        false, // Verberg het selectievinkje
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 10),
                          child: Divider(
                            color: Color(0xFFFBB03B),
                            thickness: 2,
                            height: 10,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ),
      )
    ]);
  }
}
