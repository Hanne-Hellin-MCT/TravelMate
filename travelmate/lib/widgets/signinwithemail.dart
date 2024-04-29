import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelmate/routes/travel/travelnavigationbar.dart';
import 'package:travelmate/widgets/forgetpassword.dart';
import 'package:travelmate/widgets/createaccount.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'dart:convert';

class signinwithemail extends StatefulWidget {
  const signinwithemail({
    super.key,
  });

  @override
  State<signinwithemail> createState() => _signinwithemailState();
}

class _signinwithemailState extends State<signinwithemail> {
  String email = '';
  String password = '';
  void login() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      print('Email: $email');
      print('Password: $password');

      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (credential.user != null) {
          final token = await _auth.currentUser!.getIdToken();
          print('Token: $token');

          final url = 'http://10.0.2.2:5092/auth/login';
          final body = {'idToken': token};
          print('Sending token to backend: $body');
          final response = await http.post(
            Uri.parse(url),
            body: body,
          );

          if (response.statusCode == 200) {
            print('Token successfully sent to backend');
            print(response.body);
            // haal alle data op van de user
            GetTravelerData(response.body);

            // Navigate to the next screen upon successful authentication
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TravelMateNavigation(),
              ),
            );
          } else {
            print('Error sending token to backend: ${response.statusCode}');
          }
        } else {
          print('User authentication failed.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else {
          print('Error: $e');
        }
      }
    } else {
      print('Email or password is empty.');
    }
  }

  void GetTravelerData(uid) async {
    // haal " " weg van uid
    uid = uid.replaceAll('"', '');
    final url = 'http://10.0.2.2:5092/travelers/$uid';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Traveler data successfully retrieved');
      print(response.body);

      // put data in provider
      final provider = Provider.of<SetupAccountData>(context, listen: false);
      final data = jsonDecode(response.body);
      for (var foto in data['photoUrls']) {
        provider.fotosurls.add(foto);
      }
      provider.setName(data['name']);
      provider.setIdToken(data['id']);
      print("id: ${data['id']}");
      provider.setGendervoorkeur(data['preferredGender']);
      print('voorkeursgender ${data['preferredGender']}');
      //set birthdate
      provider.setBirthdate(DateTime.parse(data['birthdate']));
      provider.setGender(data['gender']);
      provider.setBio(data['bio']);

      provider.setAfstandvoorkeur(data['preferredDistance']);
      provider.minleeftijdvoorkeur = data['preferredMinAge'];
      provider.maxleeftijdvoorkeur = data['preferredMaxAge'];
      // fotos

      for (var interest in data['interests']) {
        provider.addInterest(interest);
      }
      print('Provider data: ${provider.name}');
      print('fotos ${provider.fotosurls}');
    } else {
      print('Error retrieving traveler data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20, // Afstand vanaf de onderkant
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF7F6F0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // onderaan uitlijnen
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 70.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                // set value standaard op hanne.hellin2004@gmail.com

                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFFFBB03B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFFBB03B)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: const TextStyle(color: Color(0xFFFBB03B)),
                  fillColor: Colors.white,
                  hintText: 'Enter your email address',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFFFBB03B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFFBB03B)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: const TextStyle(color: Color(0xFFFBB03B)),
                  fillColor: Colors.white,
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  print('Login button pressed');
                  login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBB03B),
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  print("wachtwoord vergeten");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPassword(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Wachtwoord vergeten?',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFFBB03B), // Gele kleur
                      decoration: TextDecoration.underline, // Onderlijnde tekst
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  //navigate to create account
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccount(),
                    ),
                  );
                  print("nog geen account");
                },
                child: const Center(
                  child: Text(
                    'Nog geen account?',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFFBB03B), // Gele kleur
                      decoration: TextDecoration.underline, // Onderlijnde tekst
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
