import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';

class Explore extends StatefulWidget {
  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  //fetch data from API

  List<Map> fetchdata = []; // Initialize data as an empty list

  // Function to fetch data from API
  Future<void> fetchData() async {
    final travelerid =
        Provider.of<SetupAccountData>(context, listen: false).getIdToken();
    final url =
        'http://10.0.2.2:5092/trips/recommended/${travelerid}'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          // Update the data list with the fetched data
          fetchdata =
              jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
        });
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    // Call the fetchData function when the state is initialized
    fetchData().then((_) {
      // This code will execute after fetchData completes
      print("fetchdata");
      print(fetchdata);
    });
    super.initState();
  }

  int currentIndex = 0;

  Future<bool> _onSwipe(
      int index, int? previousIndex, CardSwiperDirection direction) async {
    if (currentIndex >= fetchdata.length) {
      return false;
    }

    setState(() {
      currentIndex = index + 1;
      if (currentIndex >= fetchdata.length) {
        // Als alle kaarten zijn geswiped, leeg de lijst met kaarten.
        fetchdata.clear();
      }
    });

    if (direction == CardSwiperDirection.right) {
      print('Kaart geswiped naar rechts');
      // new userinteraction with the api and isliked true
      //het id van de kaart die geswiped is naar rechts
      print(fetchdata[index]['id']);

      // get the travelerid from the provider
      final provider = Provider.of<SetupAccountData>(context, listen: false);
      print(provider.getIdToken());

      // post request to the backend
      final url = 'http://10.0.2.2:5092/userinteractions';

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'TravelerId': provider.getIdToken(),
          'TripId': fetchdata[index]['id'],
          'Isliked': true,
        }),
      );
      if (response.statusCode == 200) {
        print('Userinteraction successfully added');
      } else {
        print('Error adding userinteraction');
        print(response.body);
        print(response.statusCode);
      }
    }
    if (direction == CardSwiperDirection.left) {
      print('Kaart geswiped naar links');
      // new userinteraction with the api and isliked false
      print(fetchdata[index]['id']);

      // get the travelerid from the provider
      final provider = Provider.of<SetupAccountData>(context, listen: false);
      print(provider.getIdToken());

      // post request to the backend
      final url = 'http://10.0.2.2:5092/userinteractions';

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'TravelerId': provider.getIdToken(),
          'TripId': fetchdata[index]['id'],
          'Isliked': false,
        }),
      );

      if (response.statusCode == 200) {
        print('Userinteraction successfully added');
      } else {
        print('Error adding userinteraction');
      }
    }

    return true; // Deze waarde geeft aan dat de swipe wordt geaccepteerd.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // without backbutton
          automaticallyImplyLeading: false,
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
          backgroundColor: const Color(0xFFF7F6F0),
        ),
        body: fetchdata.isNotEmpty
            ? CardSwiper(
                cardsCount: fetchdata.length,
                numberOfCardsDisplayed: fetchdata.length > 0 ? 1 : 0,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  // Maak een kaart voor elk object in de lijst 'data'
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    width: MediaQuery.of(context)
                        .size
                        .width, // Breedte instellen op de breedte van het scherm
                    child: Card(
                      color: const Color(0xFFFFC161),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              //borderradius
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              height: 450, // Hoogte instellen als gewenst
                              width:
                                  double.infinity, // Breedte van de container
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  fetchdata[index]['fotosURL'],
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(fetchdata[index]['name']!,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(DateFormat('dd MMMM').format(
                                    DateTime.parse(
                                        fetchdata[index]['startDate']))),
                              ),
                              const Text(' - '),
                              Text(DateFormat('dd MMMM').format(
                                  DateTime.parse(fetchdata[index]['endDate']))),
                            ],
                          ),
                          Wrap(
                            spacing: 8.0, // Spacing between the containers
                            children: (fetchdata[index]['features']
                                    as List<dynamic>)
                                .take(3)
                                .toList()
                                .map<Widget>((feature) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFFBB03B),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: const Color(0xFFF7F6F0),
                                ),
                                child: Text(
                                  feature.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                                fetchdata[index]['description'].toString()),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                onSwipe: _onSwipe,
              )
            : Center(
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
              ));
  }
}
