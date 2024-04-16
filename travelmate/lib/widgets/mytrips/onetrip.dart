import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelmate/widgets/mytrips/tripmatches.dart';
import 'package:travelmate/widgets/mytrips/trippossiblematches.dart';

class OneTrip extends StatefulWidget {
  final Map data;

  const OneTrip({required Key key, required this.data}) : super(key: key);

  @override
  State<OneTrip> createState() => _OneTripState();
}

class _OneTripState extends State<OneTrip> {
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
            Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFBB03B),
              ),
            ),

            //knoppen
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return PossibleMatches(key: UniqueKey(), data: widget.data);
                  }));
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
                    'Bekijk wie mee wil',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return TripMatches(key: UniqueKey(), data: widget.data);
                  }));
                  print('bekijk matches voor deze reis');
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
                    'Matches voor deze reis',
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
