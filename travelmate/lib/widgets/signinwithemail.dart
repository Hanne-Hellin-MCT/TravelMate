import 'package:flutter/material.dart';

class signinwithemail extends StatelessWidget {
  const signinwithemail({
    super.key,
  });
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
                onPressed: () {},
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
                child: const Text('Log in'),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {},
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
