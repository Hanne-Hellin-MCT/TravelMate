import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import "package:story_view/story_view.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class PossibleMatches extends StatefulWidget {
  final Map data;

  const PossibleMatches({required Key key, required this.data})
      : super(key: key);

  @override
  State<PossibleMatches> createState() => _PossibleMatchesState();
}

class _PossibleMatchesState extends State<PossibleMatches> {
  List<Map<String, dynamic>> travelers = [];

  @override
  void initState() {
    super.initState();
    // Riep fetchTravelers aan om reisgegevens op te halen
    fetchTravelers();
  }

  // fetch data from the backend
  void fetchTravelers() async {
    // Maak een GET request naar de backend
    final tripId = widget.data['id'];
    print(' tripId $tripId');
    final url =
        'http://10.0.2.2:5092/travelers/possiblematches/${tripId.toString()}';
    final response = await http.get(Uri.parse(url));
    print(response.body);

    if (response.statusCode == 200) {
      // Als de server een OK response geeft, parse de JSON data
      print('status code 200');
      final List<dynamic> data = jsonDecode(response.body);
      // add to travelers list
      setState(() {
        travelers = data.cast<Map<String, dynamic>>();
      });
      print(data);
      print(travelers);
    }
  }

  int currentIndex = 0;

  bool _onSwipe(int index, int? previousIndex, CardSwiperDirection direction) {
    setState(() {
      currentIndex = index + 1;
      if (currentIndex >= travelers.length) {
        // Als alle kaarten zijn geswiped, leeg de lijst met kaarten.
        travelers.clear();
      }

      if (direction == CardSwiperDirection.right) {
        print('Kaart geswiped naar rechts');
        //print the id of the traveler
        print(travelers[index]['id']);
        // print id of the trip
        print(widget.data['id']);
        final travelerid = travelers[index]['id'];
        final tripid = widget.data['id'];
        // Voeg de match toe aan de database
        final url =
            'http://10.0.2.2:5092/userinteractions/accept/${travelerid}/${tripid}';

        http.put(Uri.parse(url)).then((response) {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
        });
      }
      if (direction == CardSwiperDirection.left) {
        print('Kaart geswiped naar links');
        final travelerid = travelers[index]['id'];
        final tripid = widget.data['id'];
        // Voeg de match toe aan de database
        final url =
            'http://10.0.2.2:5092/userinteractions/decline/${travelerid}/${tripid}';

        http.put(Uri.parse(url)).then((response) {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
        });
      }
    });

    return true; // Deze waarde geeft aan dat de swipe wordt geaccepteerd.
  }

  final controller = StoryController();

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
      body: travelers.isEmpty
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
                    'Oeps! Geen mogelijke matches meer voor deze trip!',
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
              cardsCount: travelers.length,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: const Color(0xFFFFC161),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          child: StoryView(
                            storyItems: travelers[index]['photoUrls']
                                .map<StoryItem>((url) {
                              return StoryItem.pageImage(
                                  url: url.toString(), controller: controller);
                            }).toList(),
                            progressPosition: ProgressPosition.top,
                            // dont go automatically to the next page
                            repeat: true,
                            onStoryShow: (storyItem, index) =>
                                print('Showing a story'),
                            controller: controller, // pass controller here too
                            inline: false,
                            onComplete: () {},
                            // Preferrably for inline story view.
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Text(travelers[index]['name'] ?? 'No name',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        Wrap(
                          spacing: 8.0, // Spacing between the containers
                          children: travelers[index]['features'] != null
                              ? travelers[index]['features']
                                  .map<Widget>((feature) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFFBB03B),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color(0xFFF7F6F0),
                                    ),
                                    child: Text(
                                      feature,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList()
                              : [const Text('No features listed')],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(travelers[index]['bio'].toString()),
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
