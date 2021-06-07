import 'dart:convert';

import 'package:covidapp/adState.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/screens/boardingScreen.dart';
import 'package:covidapp/screens/homeScreen.dart';
import 'package:covidapp/userPrefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';



void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await UserPreferences().init();
  runApp(MyApp());


}
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

List WMapResponse;
List WListResponse;
Map mapResponse;
bool download = false;

class _MyAppState extends State<MyApp> {

  Future fetchData() async {
    http.Response response2;
    var url2 = Uri.parse("https://coronavirus-19-api.herokuapp.com/countries");
    response2 = await http.get(url2);
    http.Response response3;
    var url3 =
    Uri.parse("https://api.covid19india.org/v4/min/data-all.min.json");
    response3 = await http.get(url3);

    print(response2.statusCode);

    print(response3.statusCode);
    if (response2.statusCode == 200 && response3.statusCode == 200) {
      setState(() {
        WMapResponse = json.decode(response2.body);
        mapResponse= json.decode(response3.body);
        download = true;
      });
    }
  }
  @override
  void initState() {
    fetchData();


    // TODO: implement initState
    super.initState();
  }

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

