import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Explore extends StatefulWidget {
  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
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
  ];

  int currentIndex = 0;

  bool _onSwipe(int index, int? previousIndex, CardSwiperDirection direction) {
    setState(() {
      currentIndex = index + 1;
      if (currentIndex >= data.length) {
        // Als alle kaarten zijn geswiped, leeg de lijst met kaarten.
        data.clear();
      }

      if (direction == CardSwiperDirection.right) {
        print('Kaart geswiped naar rechts');
      }
      if (direction == CardSwiperDirection.left) {
        print('Kaart geswiped naar links');
      }
    });

    return true; // Deze waarde geeft aan dat de swipe wordt geaccepteerd.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'lib/assets/logo.svg',
                    width: 250,
                    height: 250,
                  ),
                  const Text(
                    'Oeps! Geen plannen meer die voldoen aan jouw interesses.',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFBB03B),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : CardSwiper(
              cardsCount: data.length,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) {
                // Maak een kaart voor elk object in de lijst 'data'
                return Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Breedte instellen op de breedte van het scherm
                  child: Card(
                    color: const Color(0xFFFFC161),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 500, color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Text(data[index]['destination']!,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(DateFormat('dd MMMM')
                                  .format(data[index]['enddate'])),
                            ),
                            const Text(' - '),
                            Text(DateFormat('dd MMMM')
                                .format(data[index]['enddate'])),
                          ],
                        ),
                        Wrap(
                          spacing: 8.0, // Spacing between the containers
                          children:
                              data[index]['features'].map<Widget>((feature) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFFBB03B), width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFFF7F6F0),
                              ),
                              child: Text(
                                feature,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(data[index]['uitleg'].toString()),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onSwipe: _onSwipe,
            ),
    );
  }
}
