import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:travelmate/widgets/mytrips/addtrip.dart';
import 'package:travelmate/widgets/mytrips/onetrip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MytripsOverview extends StatefulWidget {
  const MytripsOverview({
    super.key,
  });

  @override
  State<MytripsOverview> createState() => _MytripsOverviewState();
}

class _MytripsOverviewState extends State<MytripsOverview> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<Map> fetchdata = []; // Initialize data as an empty list

  //
  Future<void> fetchData() async {
    final provider = Provider.of<SetupAccountData>(context, listen: false);
    print("idtokenjklhklj: ${provider.getIdToken()}");
    final url = 'http://10.0.2.2:5092/trips/tripsfrom/${provider.getIdToken()}';
    try {
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          // Update the data list with the fetched data
          fetchdata =
              jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
        });
        print('Data fetched: $fetchdata');
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                children: [
                  TextSpan(
                    text: 'Travel',
                  ),
                  TextSpan(
                    text: 'Mate',
                    style: TextStyle(
                      color: Color(0xFFFBB03B), // Gele kleur
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('Add button tapped');
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const AddTrip();
                }));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        100), // Afgeronde hoeken instellen
                    side: const BorderSide(color: Color(0xFFFBB03B), width: 2),
                  ),
                  backgroundColor: const Color(0xFFF7F6F0)),
              child: const Text(
                '+',
                style: TextStyle(fontSize: 30, color: Color(0xFFFBB03B)),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: 690,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: fetchdata.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return OneTrip(key: UniqueKey(), data: fetchdata[index]);
                    }));
                    print('Card tapped: ${fetchdata[index]['destination']}');
                  },
                  child: Card(
                    color: const Color(0xFFFFC161),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10), // Afgeronde hoeken toevoegen
                              color: Colors.yellow,
                            ),
                            child: fetchdata[index]['fotosURL'] != null
                                ? ClipRRect(
                                    // ClipRRect om de afbeelding af te ronden
                                    borderRadius: BorderRadius.circular(
                                        10), // Dezelfde hoeken als de container
                                    child: Image.network(
                                      fetchdata[index]['fotosURL'],
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Center(
                                    child: Text(
                                      'No Image Available',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(
                                        fetchdata[index]['startDate']))),
                                Text(' - '),
                                Text(DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(
                                        fetchdata[index]['endDate']))),
                              ],
                            ),
                          ),
                          Text(
                            fetchdata[index]['destination'],
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
