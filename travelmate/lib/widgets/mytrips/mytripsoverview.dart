import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/addtripprovider.dart';
import 'package:travelmate/widgets/mytrips/addtrip.dart';
import 'package:travelmate/widgets/mytrips/onetrip.dart';

class MytripsOverview extends StatefulWidget {
  const MytripsOverview({
    super.key,
  });

  @override
  State<MytripsOverview> createState() => _MytripsOverviewState();
}

class _MytripsOverviewState extends State<MytripsOverview> {
  List<Map> data = [
    {
      'destination': 'Destination 1',
      'startdate': DateTime.now(),
      'enddate': DateTime.now(),
      'features': ['Feature 1', 'Feature 2'],
      'uitleg':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ',
    },
    {
      'destination': 'Destination 2',
      'startdate': DateTime.now(), // Corrected to 'startdate' instead of 'date'
      'enddate': DateTime.now(), // Corrected to 'enddate' instead of 'date'

      'features': ['Feature 1', 'Feature 2'],
      'uitleg':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ',
    },
    {
      'destination': 'Destination 3',
      'startdate': DateTime.now(), // Corrected to 'startdate' instead of 'date'
      'enddate': DateTime.now(), // Corrected to 'enddate' instead of 'date'

      'features': ['Feature 1', 'Feature 2'],
      'uitleg':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ',
    },
    {
      'destination': 'Destination 3',
      'startdate': DateTime.now(), // Corrected to 'startdate' instead of 'date'
      'enddate': DateTime.now(), // Corrected to 'enddate' instead of 'date'

      'features': ['Feature 1', 'Feature 2'],
      'uitleg':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ',
    },
    {
      'destination': 'Destination 4',
      'startdate': DateTime.now(), // Corrected to 'startdate' instead of 'date'
      'enddate': DateTime.now(), // Corrected to 'enddate' instead of 'date'

      'features': ['Feature 1', 'Feature 2'],
      'uitleg':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ',
    },
    {
      'destination': 'Destination 5',
      'startdate': DateTime.now(), // Corrected to 'startdate' instead of 'date'
      'enddate': DateTime.now(), // Corrected to 'enddate' instead of 'date'

      'features': ['Feature 1', 'Feature 2'],
      'uitleg':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ',
    },
  ];

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
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return OneTrip(key: UniqueKey(), data: data[index]);
                    }));
                    print('Card tapped: ${data[index]['destination']}');
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
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('01-01-2022'),
                                Text(' - '),
                                Text('01-01-2022'),
                              ],
                            ),
                          ),
                          Text(
                            data[index]['destination'],
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
