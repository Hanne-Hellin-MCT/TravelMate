import 'package:flutter/material.dart';
import 'package:travelmate/routes/auth/credentials.dart';
import 'package:travelmate/routes/setupaccount/setupaccount.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFF7F6F0),
          background: const Color(0xFFF7F6F0),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF000000)),
        ),
      ),
      home: const Scaffold(
        body: SetupAccount(),
      ),
    );
  }
}
