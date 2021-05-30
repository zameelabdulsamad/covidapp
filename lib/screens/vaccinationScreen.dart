import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({Key key}) : super(key: key);

  @override
  _VaccinationScreenState createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  Future<Map<String, dynamic>> postRequest() async {
    // todo - fix baseUrl
    var url = Uri.parse('https://coronavirus-smartable.p.rapidapi.com/stats/v1/IN/');





    var response = await http.get(
      url,
      headers: {
        'x-rapidapi-host': 'coronavirus-smartable.p.rapidapi.com',
        'x-rapidapi-key': '3800574636msh050a9500bde3d58p1106fdjsn91a8dcd36014',
      },




    );

    print(response.statusCode);

    // todo - handle non-200 status code, etc

    print(json.decode(response.body));

  }

  @override
  void initState() {
    postRequest();


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
