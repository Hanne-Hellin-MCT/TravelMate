import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:provider/provider.dart';

class SetupAccountInterests extends StatefulWidget {
  const SetupAccountInterests({
    super.key,
  });

  @override
  State<SetupAccountInterests> createState() => _SetupAccountInterestsState();
}

class _SetupAccountInterestsState extends State<SetupAccountInterests> {
  List<String> interests1 = [
    'Avontuurlijk',
    'Citytrip',
    'Hiking',
    'Rondreis',
    'Camping',
    'Backpacking',
    'Wintersport',
    'Platteland',
  ];

  List<String> interests2 = [
    'Camping',
    'Hotel',
    'Hostel',
    'Appartement',
    'Vakantiehuis',
    'Bed & Breakfast',
    'Glamping',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
          child: RichText(
            textAlign: TextAlign.start,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
              children: [
                TextSpan(
                  text: 'Wat zijn je ',
                ),
                TextSpan(
                  text: 'Interesses',
                  style: TextStyle(
                    color: Color(0xFFFBB03B), // Gele kleur
                  ),
                ),
                TextSpan(
                  text: '?',
                ),
              ],
            ),
          ),
        ),

        // Interesses toevoegen in lijst
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      'lib/assets/pasport.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Text(
                    'Wat is je favoriete reisstijl?',
                    style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Wrap(
                spacing: 10.0, // Ruimte tussen de chips
                runSpacing: 10.0, // Ruimte tussen de rijen
                children: interests1
                    .map(
                      (interest) => ChoiceChip(
                        label: Text(interest),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0), // Aangepaste interne padding
                        selected: context
                            .read<SetupAccountData>()
                            .interests
                            .contains(interest),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              context
                                  .read<SetupAccountData>()
                                  .addInterest(interest);
                            } else {
                              context
                                  .read<SetupAccountData>()
                                  .removeInterest(interest);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color(
                                0xFFFBB03B), // Geen randkleur als niet geselecteerd
                            width: 2.0, // Dikte van de rand
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Borderradius van de chip
                        ),
                        backgroundColor: const Color(0xFFF7F6F0),
                        selectedColor: const Color(0xFFFBB03B),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: context
                                  .read<SetupAccountData>()
                                  .interests
                                  .contains(interest)
                              ? Colors.white // Witte tekst als geselecteerd
                              : Colors.black,
                          // Zwarte tekst als niet geselecteerd
                        ),
                        showCheckmark: false, // Verberg het selectievinkje
                      ),
                    )
                    .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
              child: Divider(
                color: Color(0xFFFBB03B),
                thickness: 2,
                height: 10,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      'lib/assets/wallet.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Text(
                    'Welk soort accommodatie?',
                    style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Wrap(
                spacing: 10.0, // Ruimte tussen de chips
                runSpacing: 10.0, // Ruimte tussen de rijen
                children: interests2
                    .map(
                      (interest) => ChoiceChip(
                        label: Text(interest),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0), // Aangepaste interne padding
                        selected: context
                            .read<SetupAccountData>()
                            .interests
                            .contains(interest),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              context
                                  .read<SetupAccountData>()
                                  .addInterest(interest);
                            } else {
                              context
                                  .read<SetupAccountData>()
                                  .removeInterest(interest);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color(
                                0xFFFBB03B), // Geen randkleur als niet geselecteerd
                            width: 2.0, // Dikte van de rand
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Borderradius van de chip
                        ),
                        backgroundColor: const Color(0xFFF7F6F0),
                        selectedColor: const Color(0xFFFBB03B),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: context
                                  .read<SetupAccountData>()
                                  .interests
                                  .contains(interest)
                              ? Colors.white // Witte tekst als geselecteerd
                              : Colors.black,
                          // Zwarte tekst als niet geselecteerd
                        ),
                        showCheckmark: false, // Verberg het selectievinkje
                      ),
                    )
                    .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
              child: Divider(
                color: Color(0xFFFBB03B),
                thickness: 2,
                height: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
