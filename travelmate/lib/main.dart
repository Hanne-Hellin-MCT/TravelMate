import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/routes/auth/credentials.dart';
import 'package:travelmate/provider/SetupAccountProvider.dart';
import 'package:travelmate/routes/setupaccount/setupaccount.dart';
import 'package:travelmate/routes/travel/travelnavigationbar.dart';
import 'package:travelmate/routes/travel/mytrips.dart';
import 'package:travelmate/widgets/mytrips/addtrip.dart';
import 'package:travelmate/provider/addtripprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SetupAccountData()),
      ChangeNotifierProvider(create: (_) => AddTripData()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('Provider addtripdata main');
    print(Provider.of<AddTripData>(context).tripname);

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
        body: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Credentials(),
        ),
      ),
    );
  }
}
