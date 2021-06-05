import 'package:covidapp/adState.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/screens/boardingScreen.dart';
import 'package:covidapp/screens/homeScreen.dart';
import 'package:covidapp/userPrefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';



void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(MyApp());


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


      home: UserPreferences().districtName == null || UserPreferences().districtName == ""?BoardingScreen():HomeScreen(),
    );
  }
}

