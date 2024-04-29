import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';

class SetupAccountPhotos extends StatefulWidget {
  const SetupAccountPhotos({
    super.key,
  });

  @override
  State<SetupAccountPhotos> createState() => _SetupAccountPhotosState();
}

class _SetupAccountPhotosState extends State<SetupAccountPhotos> {
  List<String> photoUrls = [];

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
                  _buildPhotoSquare(210, 210, true, context, 0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPhotoSquare(100, 100, false, context, 1),
                      _buildPhotoSquare(100, 100, false, context, 2),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  _buildPhotoSquare(100, 100, false, context, 3),
                  _buildPhotoSquare(100, 100, false, context, 4),
                  _buildPhotoSquare(100, 100, false, context, 5),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoSquare(double width, double height, bool isAddButton,
      BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () async {
          if (isAddButton) {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              File imageFile = File(pickedFile.path);
              // Upload the image to Firebase Storage
              String imageUrl = await uploadImageToFirebase(imageFile);
              // Do something with the image URL, like saving it to Firestore
              print('Image URL: $imageUrl');

              // Update the UI
              setState(() {
                // Update the provider with the new image URL
                Provider.of<SetupAccountData>(context, listen: false)
                    .addFotoUrl(imageUrl);
                photoUrls.add(imageUrl);
              });
            } else {
              print('No image selected.');
            }
          }
        },
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
              : photoUrls.length > index
                  ? Image.network(
                      photoUrls[index],
                      fit: BoxFit
                          .cover, // Toegevoegd om de afbeelding binnen het vakje te passen
                    )
                  : Container(), // Leeg container als geen add knop nodig is
        ),
      ),
    );
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images/$fileName');
      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      print("Image uploaded to Firebase Storage: $imageUrl");
      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }
}
