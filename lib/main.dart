import 'package:covidapp/constants.dart';
import 'package:covidapp/screens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main () async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Point',
      theme: ThemeData(
        primaryColor: bgGrey,
        scaffoldBackgroundColor: bgWhite,
        textTheme: Theme.of(context).textTheme.apply(displayColor: primaryText),

      ),


      home: HomeScreen(),
    );
  }
}

