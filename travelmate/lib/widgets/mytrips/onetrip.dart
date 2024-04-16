import 'package:flutter/material.dart';

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
        title: Text(widget.data['destination']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start Date: ${widget.data['startdate']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'End Date: ${widget.data['enddate']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Features: ${widget.data['features'].join(", ")}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Explanation: ${widget.data['uitleg']}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
