import 'package:covidapp/screens/homeScreen.dart';
import 'package:covidapp/statesList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class WorldwideScreen extends StatefulWidget {
  const WorldwideScreen({Key key}) : super(key: key);

  @override
  _WorldwideScreenState createState() => _WorldwideScreenState();
}

class _WorldwideScreenState extends State<WorldwideScreen> {
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgGrey,
          elevation: 0,
          title: Text("Worldwide"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgGrey,
            ),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: bgGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                                NumberFormat.decimalPattern().format(
                                    int.parse(WMapResponse[0]["todayCases"]
                                        .toString())),
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("CONFIRMED",
                                style: TextStyle(
                                  color: cardYellow,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(
                                NumberFormat.decimalPattern().format(
                                    int.parse(
                                        WMapResponse[0]["cases"].toString())),
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                                NumberFormat.decimalPattern().format(
                                    int.parse(WMapResponse[0]["active"]
                                        .toString())),
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("RECOVERED",
                                style: TextStyle(
                                  color: cardGreen,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(
                                NumberFormat.decimalPattern().format(
                                    int.parse(WMapResponse[0]["recovered"]
                                        .toString())),
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                                NumberFormat.decimalPattern().format(
                                    int.parse(WMapResponse[0]["todayDeaths"]
                                        .toString())),
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("DECEASED",
                                style: TextStyle(
                                  color: primaryRed,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(
                                NumberFormat.decimalPattern().format(
                                    int.parse(WMapResponse[0]["deaths"]
                                        .toString())),
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            child: Container(
                width: double.infinity,
                child: new ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: WMapResponse.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return index==0?Container():Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new CountryCard(
                          country: index,
                        ),
                      );
                    })),
          ),
        ])));
  }
}

class CountryCard extends StatelessWidget {
  final int country;

  const CountryCard({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, left: 10, bottom: 20, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        WMapResponse[country]["country"].toString(),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 26, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                          NumberFormat.decimalPattern()
                              .format(int.parse(getWorldwide("todayCases"))),
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("CONFIRMED",
                          style: TextStyle(
                            color: cardYellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                          NumberFormat.decimalPattern()
                              .format(int.parse(getWorldwide("cases"))),
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 14,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                          NumberFormat.decimalPattern()
                              .format(int.parse(getWorldwide("active"))),
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("RECOVERED",
                          style: TextStyle(
                            color: cardGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                          NumberFormat.decimalPattern()
                              .format(int.parse(getWorldwide("recovered"))),
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 14,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                          NumberFormat.decimalPattern()
                              .format(int.parse(getWorldwide("todayDeaths"))),
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("DECEASED",
                          style: TextStyle(
                            color: primaryRed,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                          NumberFormat.decimalPattern()
                              .format(int.parse(getWorldwide("deaths"))),
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 14,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getWorldwide(String item) {
    if (WMapResponse[country] == null) {
      return 0.toString();
    } else if (WMapResponse[country][item] == null) {
      return 0.toString();
    } else {
      return WMapResponse[country][item].toString();
    }
  }
}
