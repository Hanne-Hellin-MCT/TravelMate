import 'package:flutter/material.dart';
import 'package:travelmate/routes/travel/explore.dart';
import 'package:travelmate/routes/travel/mytrips.dart';
import 'package:travelmate/routes/travel/settings.dart';

class TravelMateNavigation extends StatefulWidget {
  const TravelMateNavigation({super.key});

  @override
  State<TravelMateNavigation> createState() => _TravelMateNavigationState();
}

class _TravelMateNavigationState extends State<TravelMateNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.backpack_outlined, size: 32),
            label: 'My trips',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined, size: 32),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, size: 32),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// my trips
        MyTrips(),

        /// explore
        Explore(),

        /// settings
        Settings(),
      ][currentPageIndex],
    );
  }
}
