import 'package:flutter/material.dart';
import 'package:travelmate/widgets/mytrips/mytripsoverview.dart';

class MyTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
             
              MytripsOverview()
            ],
          )),
    );
  }
}
