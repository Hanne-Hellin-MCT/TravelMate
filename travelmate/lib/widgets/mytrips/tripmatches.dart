import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripMatches extends StatefulWidget {
  final Map data;

  const TripMatches({required Key key, required this.data}) : super(key: key);

  @override
  State<TripMatches> createState() => _TripMatchesState();
}

class _TripMatchesState extends State<TripMatches> {
  @override
  Widget build(BuildContext context) {
    
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('dd MMMM').format(widget.data['startdate'])),
                const Text(' - '),
                Text(DateFormat('dd MMMM').format(widget.data['enddate'])),
              ],
            ),

            //knoppen
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ElevatedButton(
                onPressed: () {
                  print('bekijk wie mee wil');
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFFFBB03B),
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFFF7F6F0),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: const Text(
                    'Match',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
