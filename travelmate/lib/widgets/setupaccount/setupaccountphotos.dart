import 'package:flutter/material.dart';

class SetupAccountPhotos extends StatelessWidget {
  const SetupAccountPhotos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 20),
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
                  text: 'Voeg ',
                ),
                TextSpan(
                  text: 'foto\'s ',
                  style: TextStyle(
                    color: Color(0xFFFBB03B), // Gele kleur
                  ),
                ),
                TextSpan(
                  text: 'toe',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPhotoSquare(210, 210, true),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPhotoSquare(100, 100, false),
                      _buildPhotoSquare(100, 100, false),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  _buildPhotoSquare(100, 100, false),
                  _buildPhotoSquare(100, 100, false),
                  _buildPhotoSquare(100, 100, false),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7F6F0),
                side: const BorderSide(color: Color(0xFFFBB03B), width: 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                width: double.infinity, // Volledige breedte
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0), // Aangepaste padding
                child: const Text(
                  'Volgende',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center, // Tekst centreren binnen de knop
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildPhotoSquare(double width, double height, bool isAddButton) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        //afgeronde hoeken
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFFBB03B), // Gele randkleur
          width: 3,
        ),
      ),
      child: isAddButton
          ? Center(
              child: Icon(
                Icons.add, // Pluspictogram
                size: width / 2, // Grootte van het pluspictogram
                color: Color(0xFFFBB03B), // Gele pluskleur
              ),
            )
          : Container(), // Leeg container als geen add knop nodig is
    ),
  );
}
