import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistrictScreen extends StatefulWidget {
  const DistrictScreen({Key key}) : super(key: key);

  @override
  _DistrictScreenState createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {

  Map mapResponse;
  Future fetchData() async{
    http.Response response;
    var url = Uri.parse("https://api.covid19india.org/v4/min/data-all.min.json");
    response = await http.get(url);
    if(response.statusCode==200){
      setState(() {
        mapResponse=json.decode(response.body);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text("Malappuram"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgGrey,
              ),
              child: Wrap(
                children: [



                ],
              ),
            ),
            mapResponse==null?Container():Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(mapResponse['2021-05-13']['KL']['districts']['Thrissur']["delta"].toString()),
            )
          ],
        ),
      ),
    );
  }
}
