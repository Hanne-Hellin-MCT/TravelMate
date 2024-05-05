import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TripMatches extends StatefulWidget {
  final Map data;

  const TripMatches({required Key key, required this.data}) : super(key: key);

  @override
  State<TripMatches> createState() => _TripMatchesState();
}

class _TripMatchesState extends State<TripMatches> {
  List<dynamic> travelers = []; // List to store travelers

  @override
  void initState() {
    super.initState();
    // Riep fetchMatches aan om reisgegevens op te halen
    fetchMatches();
  }

  // get the matches
  void fetchMatches() async {
    // Maak een GET request naar de backend
    final tripId = widget.data['id'];
    print(' tripId $tripId');
    final url = 'http://10.0.2.2:5092/travelers/matches/$tripId';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        travelers = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if 'startdate' and 'enddate' are not null

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F6F0),
        title: RichText(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${widget.data['destination']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: travelers.length,
                itemBuilder: (BuildContext context, int index) {
                  final traveler = travelers[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Color(0xFFFBB03B), width: 2.0),
                    ),
                    child: ListTile(
                        title: Text(
                          traveler['name'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Add functionality when tapping on a traveler card
                          print('Selected traveler: ${traveler['name']}');
                          _showChatAppPopup(context, traveler['name']);
                        },
                        //ronde hoeken
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        //kleur van de kaart
                        //randen van de kaart geel
                        tileColor: Color(0xFFFBB03B).withOpacity(0.2),
                        selectedTileColor: Color(0xFFFBB03B).withOpacity(0.5)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showChatAppPopup(BuildContext context, String travelerName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chat met $travelerName'),
        content: Text('Chat functionaliteit is nog niet geïmplementeerd'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Sluit de pop-up
            },
            child: Text('Sluiten'),
          ),
        ],
      );
    },
  );
}
