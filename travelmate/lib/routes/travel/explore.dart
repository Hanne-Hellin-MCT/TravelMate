import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Explore extends StatefulWidget {
  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Map<String, String>> data = [
    {'title': 'Titel 1', 'description': 'Beschrijving 1'},
    {'title': 'Titel 2', 'description': 'Beschrijving 2'},
    {'title': 'Titel 3', 'description': 'Beschrijving 3'}
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data[index]['title']!), // Titel
                        Text(data[index]['description']!), // Beschrijving
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
