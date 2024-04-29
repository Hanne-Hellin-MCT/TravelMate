import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelmate/provider/addtripprovider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddTripFeatures extends StatefulWidget {
  const AddTripFeatures({
    super.key,
  });

  @override
  State<AddTripFeatures> createState() => _AddTripFeaturesState();
}

class _AddTripFeaturesState extends State<AddTripFeatures> {
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

  List<Map> fetchData = []; // Initialize data as an empty list

  // Function to fetch data from API
  Future<void> _fetchData() async {
    final url =
        'http://10.0.2.2:5092/features'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          // Update the data list with the fetched data
          fetchData =
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
    _fetchData().then((_) {
      // This code will execute after fetchData completes
      print("fetchData");
      print(fetchData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 50, left: 20, bottom: 20),
          child: Text(
            'Select Trip Features',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
          ),
        ),
        Container(
          height: 600,
          child: SingleChildScrollView(
            child: Wrap(
              children: fetchData.map((item) {
                return Column(
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
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children:
                            (item['opties'] as List<dynamic>).map((feature) {
                          return ChoiceChip(
                            label: Text(feature),
                            selected: context
                                .read<AddTripData>()
                                .features
                                .contains(feature),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  context
                                      .read<AddTripData>()
                                      .addFeature(feature);
                                } else {
                                  context
                                      .read<AddTripData>()
                                      .removeFeature(feature);
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFFFBB03B),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: context
                                    .read<AddTripData>()
                                    .features
                                    .contains(feature)
                                ? Color(0xFFFBB03B)
                                : Color(
                                    0xFFF7F6F0), // Change background color based on selection
                            selectedColor: Color(0xFFFBB03B),
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: context
                                      .read<AddTripData>()
                                      .features
                                      .contains(feature)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            showCheckmark: false,
                          );
                        }).toList(),
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
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
  //         child: RichText(
  //           textAlign: TextAlign.start,
  //           text: const TextSpan(
  //             style: TextStyle(
  //               fontSize: 24,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xFF000000),
  //             ),
  //             children: [
  //               TextSpan(
  //                 text: 'Wat zijn de ',
  //               ),
  //               TextSpan(
  //                 text: 'kenmerken',
  //                 style: TextStyle(
  //                   color: Color(0xFFFBB03B), // Gele kleur
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: '?',
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),

  //       // Interesses toevoegen in lijst
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 10),
  //                   child: SvgPicture.asset(
  //                     'lib/assets/pasport.svg',
  //                     width: 40,
  //                     height: 40,
  //                   ),
  //                 ),
  //                 const Text(
  //                   'Wat is de reisstijl?',
  //                   style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
  //                   textAlign: TextAlign.start,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
  //             child: Wrap(
  //               spacing: 10.0, // Ruimte tussen de chips
  //               runSpacing: 10.0, // Ruimte tussen de rijen
  //               children: interests1
  //                   .map(
  //                     (interest) => ChoiceChip(
  //                       label: Text(interest),
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 8.0,
  //                           vertical: 4.0), // Aangepaste interne padding
  //                       selected: context
  //                           .read<AddTripData>()
  //                           .features
  //                           .contains(interest),
  //                       onSelected: (selected) {
  //                         setState(() {
  //                           if (selected) {
  //                             context.read<AddTripData>().addFeature(interest);
  //                           } else {
  //                             context
  //                                 .read<AddTripData>()
  //                                 .removeFeature(interest);
  //                           }
  //                         });
  //                       },
  //                       shape: RoundedRectangleBorder(
  //                         side: const BorderSide(
  //                           color: Color(
  //                               0xFFFBB03B), // Geen randkleur als niet geselecteerd
  //                           width: 2.0, // Dikte van de rand
  //                         ),
  //                         borderRadius: BorderRadius.circular(
  //                             10.0), // Borderradius van de chip
  //                       ),
  //                       backgroundColor: const Color(0xFFF7F6F0),
  //                       selectedColor: const Color(0xFFFBB03B),
  //                       labelStyle: TextStyle(
  //                         fontSize: 16,
  //                         color: context
  //                                 .read<AddTripData>()
  //                                 .features
  //                                 .contains(interest)
  //                             ? Colors.white // Witte tekst als geselecteerd
  //                             : Colors.black,
  //                         // Zwarte tekst als niet geselecteerd
  //                       ),
  //                       showCheckmark: false, // Verberg het selectievinkje
  //                     ),
  //                   )
  //                   .toList(),
  //             ),
  //           ),
  //           const Padding(
  //             padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
  //             child: Divider(
  //               color: Color(0xFFFBB03B),
  //               thickness: 2,
  //               height: 10,
  //             ),
  //           ),
  //         ],
  //       ),
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 10),
  //                   child: SvgPicture.asset(
  //                     'lib/assets/wallet.svg',
  //                     width: 40,
  //                     height: 40,
  //                   ),
  //                 ),
  //                 const Text(
  //                   'Welk soort accommodatie?',
  //                   style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
  //                   textAlign: TextAlign.start,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
  //             child: Wrap(
  //               spacing: 10.0, // Ruimte tussen de chips
  //               runSpacing: 10.0, // Ruimte tussen de rijen
  //               children: interests2
  //                   .map(
  //                     (interest) => ChoiceChip(
  //                       label: Text(interest),
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 8.0,
  //                           vertical: 4.0), // Aangepaste interne padding
  //                       selected: context
  //                           .read<AddTripData>()
  //                           .features
  //                           .contains(interest),
  //                       onSelected: (selected) {
  //                         setState(() {
  //                           if (selected) {
  //                             context.read<AddTripData>().addFeature(interest);
  //                           } else {
  //                             context
  //                                 .read<AddTripData>()
  //                                 .removeFeature(interest);
  //                           }
  //                         });
  //                       },
  //                       shape: RoundedRectangleBorder(
  //                         side: const BorderSide(
  //                           color: Color(
  //                               0xFFFBB03B), // Geen randkleur als niet geselecteerd
  //                           width: 2.0, // Dikte van de rand
  //                         ),
  //                         borderRadius: BorderRadius.circular(
  //                             10.0), // Borderradius van de chip
  //                       ),
  //                       backgroundColor: const Color(0xFFF7F6F0),
  //                       selectedColor: const Color(0xFFFBB03B),
  //                       labelStyle: TextStyle(
  //                         fontSize: 16,
  //                         color: context
  //                                 .read<AddTripData>()
  //                                 .features
  //                                 .contains(interest)
  //                             ? Colors.white // Witte tekst als geselecteerd
  //                             : Colors.black,
  //                         // Zwarte tekst als niet geselecteerd
  //                       ),
  //                       showCheckmark: false, // Verberg het selectievinkje
  //                     ),
  //                   )
  //                   .toList(),
  //             ),
  //           ),
  //           const Padding(
  //             padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
  //             child: Divider(
  //               color: Color(0xFFFBB03B),
  //               thickness: 2,
  //               height: 10,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
