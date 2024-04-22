import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:travelmate/provider/addtripprovider.dart';
import 'package:travelmate/routes/setupaccount/setupaccount.dart';
import 'package:travelmate/routes/travel/explore.dart';
import 'package:travelmate/routes/travel/mytrips.dart';
import 'package:travelmate/routes/travel/settings.dart';

class TravelMateNavigation extends StatefulWidget {
  const TravelMateNavigation({super.key}); //AddTripData foo,

  @override
  State<TravelMateNavigation> createState() => _TravelMateNavigationState();
}

class _TravelMateNavigationState extends State<TravelMateNavigation> {
  int currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print('Provider addtripdata INITSTATE nav');
    // print(Provider.of<AddTripData>(context).tripname);
  }

  @override
  Widget build(BuildContext context) {
    print('Provider addtripdata nav');
    print(Provider.of<AddTripData>(context).tripname);

    // final ThemeData theme = Theme.of(context);
    return Consumer<AddTripData>(
        // create: (_) => AddTripData(),
        // we use `builder` to obtain a new `BuildContext` that has access to the provider
        builder: (context, tripProvider, child) {
      // No longer throws
      // return const Text("hello");

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
    });
  }
}
