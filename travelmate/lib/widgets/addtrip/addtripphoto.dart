import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/addtripprovider.dart';

class AddTripPhoto extends StatefulWidget {
  const AddTripPhoto({
    super.key,
  });

  @override
  State<AddTripPhoto> createState() => _AddTripPhotoState();
}

class _AddTripPhotoState extends State<AddTripPhoto> {
  String? _imageUrl;

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
                  text: 'Voeg een ',
                ),
                TextSpan(
                  text: 'foto ',
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
          child: GestureDetector(
            onTap: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                File imageFile = File(pickedFile.path);
                // Upload the image to Firebase Storage
                String imageUrl = await uploadImageToFirebase(imageFile);
                setState(() {
                  _imageUrl = imageUrl;
                });
                // Do something with the image URL, like displaying it
                print('Image URL: $imageUrl');
                // Set the image URL in the provider
                Provider.of<AddTripData>(context, listen: false).imageUrl =
                    imageUrl;
              } else {
                print('No image selected.');
              }
            },
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                //afgeronde hoeken
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFFBB03B), // Gele randkleur
                  width: 3,
                ),
              ),
              child: _imageUrl != null
                  ? Image.network(
                      _imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Icon(
                        Icons.add, // Pluspictogram
                        size: 200 / 2, // Grootte van het pluspictogram
                        color: Color(0xFFFBB03B), // Gele pluskleur
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images/$fileName');
      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      Provider.of<AddTripData>(context, listen: false).imageUrl = imageUrl;
      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }
}
