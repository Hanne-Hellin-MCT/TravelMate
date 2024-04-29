import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:travelmate/routes/auth/credentials.dart';
import 'package:travelmate/routes/setupaccount/setupaccount.dart';
import 'package:travelmate/routes/travel/travelnavigationbar.dart';
import 'package:travelmate/widgets/signinwithemail.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  const CreateAccount({
    super.key,
  });

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String email = '';
  String password = '';

  void CreateAccount() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Future<String?> FirebaseIdToken = _auth.currentUser!.getIdToken();

      if (FirebaseIdToken != null) {
        final token = await FirebaseIdToken; // Await the Future
        print('Token: $token');
        // Use the token here (you're guaranteed it's a string)
        final url = 'http://10.0.2.2:5092/auth/login';
        final response = await http.post(
          Uri.parse(
              url), // Gebruik gewoon de URL-string zonder conversie naar Uri
          body: {'idToken': token},
        );

        if (response.statusCode == 200) {
          print('Token succesvol naar backend gestuurd');
          print(response.body);
          //clear setupaccountdata
          
          var uid = response.body.replaceAll('"', '');
          Provider.of<SetupAccountData>(context, listen: false).setIdToken(uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SetupAccount(),
            ),
          );
        } else {
          print(
              'Fout bij het verzenden van token naar backend: ${response.statusCode}');
        }
      } else {
        // Handle case where token is null (e.g., user not signed in)
        print('Token is null');
      }

      //sign de user in
      if (credential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SetupAccount(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Positioned(
        bottom: 20, // Afstand vanaf de onderkant
        left: 0,
        right: 0,
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xFFF7F6F0),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // onderaan uitlijnen
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 70.0),
                const Text('Creatte an account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000000),
                    )),
                const SizedBox(height: 20.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
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
                    labelText: 'Wachtwoord',
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
                    hintText: 'Enter your  Pasword',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    CreateAccount();
                    print('Create account');
                    //show errortext that email is send
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
                    'Create account',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    print("Inloggen");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Credentials(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Toch inloggen?',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFFFBB03B), // Gele kleur
                        decoration:
                            TextDecoration.underline, // Onderlijnde tekst
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
