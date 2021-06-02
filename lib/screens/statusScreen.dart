import 'dart:convert';

import 'package:covidapp/screens/indiaScreen.dart';
import 'package:covidapp/screens/stateScreen.dart';
import 'package:covidapp/screens/worldWideScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'districtScreen.dart';
import 'homeScreen.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  String district = "Malappuram";
  String state = "KL";
  DateTime today = DateTime.now();

  String formatDate() {
    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(today);
  }

  int getIndex() {
    DateTime _today = DateTime.now();
    var outFormatter = new DateFormat('yyyy-MM-dd');
    for (int i = 0; i < listResponse.length; i++) {
      if (listResponse[i]["dateymd"].toString() == outFormatter.format(today))
        return i;
      else if (outFormatter.format(_today) == outFormatter.format(today)) {
        return (listResponse.length - 1);
      }
    }
  }

  String getData(String item) {
    return listResponse[getIndex()]["$item"];
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text("Status"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: maxHeight * 0.35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DistrictScreen(
                                        district: "Malappuram",
                                        state: "KL",
                                      )));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: bgGrey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0,
                                      left: 10,
                                      bottom: 20,
                                      right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Malappuram",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: primaryText),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_right)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: DistrictWeekChart(
                                    mapResponseInCard: mapResponse,
                                    date: today,
                                    dateInString: formatDate(),
                                    state: state,
                                    district: district,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryRed,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.article,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text(
                                        "News",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryRed,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.medical_services_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text(
                                        "Vaccination",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StateScreen(
                                stateName: "Kerala",
                                stateCode: "KL",
                              )));
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: bgGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    "Kerala",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: primaryText),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Expanded(
                            child: AspectRatio(
                                aspectRatio: 2,
                                child: StateChart(
                                  mapResponseInCard: mapResponse,
                                  state: state,
                                  dateInString: formatDate(),
                                  date: today,
                                )),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IndiaScreen()));
                  },
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
                                    "India",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: primaryText),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 26, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(getData("dailyconfirmed"),
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
                                  Text(getData("totalconfirmed"),
                                      style: TextStyle(
                                        color: primaryText,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(getData("dailyrecovered"),
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
                                  Text(getData("totalrecovered"),
                                      style: TextStyle(
                                        color: primaryText,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(getData("dailydeceased"),
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
                                  Text(getData("totaldeceased"),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorldwideScreen()));
                  },
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
                                    "Worldwide",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: primaryText),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 26, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(WMapResponse[0]["todayCases"].toString(),
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
                                  Text(WMapResponse[0]["cases"].toString(),
                                      style: TextStyle(
                                        color: primaryText,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(WMapResponse[0]["active"].toString(),
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
                                  Text(WMapResponse[0]["recovered"].toString(),
                                      style: TextStyle(
                                        color: primaryText,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      WMapResponse[0]["todayDeaths"].toString(),
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
                                  Text(WMapResponse[0]["deaths"].toString(),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DistrictWeekChart extends StatelessWidget {
  final String state;
  final Map mapResponseInCard;
  final String dateInString;
  final DateTime date;
  final String district;

  const DistrictWeekChart(
      {Key key,
      this.state,
      this.mapResponseInCard,
      this.dateInString,
      this.date,
      this.district})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(BarChartData(
                  barGroups: getBarGroups(),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: false),
                    bottomTitles: SideTitles(showTitles: false),
                  ))))
        ],
      ),
    );
  }

  String previousDates(int x) {
    DateTime pvDate = date.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }

  double getData(int y) {
    if (mapResponseInCard == null)
      return 0;
    else if (mapResponseInCard['${previousDates(y)}'] == null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state'] == null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']
            ['districts'] ==
        null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']['districts']
            ['$district'] ==
        null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']['districts']
            ['$district']["delta"] ==
        null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']['districts']
            ['$district']["delta"]["confirmed"] ==
        null) {
      return 0;
    } else
      return double.parse(mapResponseInCard['${previousDates(y)}']['$state']
              ['districts']['$district']["delta"]["confirmed"]
          .toString());
  }

  getBarGroups() {
    List<double> barChartDatas = [
      getData(6),
      getData(5),
      getData(4),
      getData(3),
      getData(2),
      getData(1),
      getData(0)
    ];
    List<BarChartGroupData> barChartGroups = [];
    barChartDatas.asMap().forEach(
        (i, value) => barChartGroups.add(BarChartGroupData(x: i, barRods: [
              BarChartRodData(y: value, colors: [primaryRed], width: 16)
            ])));
    return barChartGroups;
  }
}

class StateChart extends StatelessWidget {
  final String state;
  final Map mapResponseInCard;
  final String dateInString;
  final DateTime date;

  const StateChart(
      {Key key,
      this.state,
      this.mapResponseInCard,
      this.date,
      this.dateInString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
              barWidth: 6,
              colors: [primaryRed],
              spots: getGraphData(),
              isCurved: false,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false))
        ]));
  }

  String previousDates(int x) {
    DateTime pvDate = date.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }

  double getData(int y) {
    if (mapResponseInCard == null)
      return 0;
    else if (mapResponseInCard['${previousDates(y)}'] == null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state'] == null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']["delta"] ==
        null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']["delta"]
            ["confirmed"] ==
        null) {
      return 0;
    } else
      return double.parse(mapResponseInCard['${previousDates(y)}']['$state']
              ["delta"]["confirmed"]
          .toString());
  }

  List<FlSpot> getGraphData() {
    return [
      FlSpot(0, getData(29)),
      FlSpot(1, getData(28)),
      FlSpot(2, getData(27)),
      FlSpot(3, getData(26)),
      FlSpot(4, getData(25)),
      FlSpot(5, getData(24)),
      FlSpot(6, getData(23)),
      FlSpot(7, getData(22)),
      FlSpot(8, getData(21)),
      FlSpot(9, getData(20)),
      FlSpot(10, getData(19)),
      FlSpot(11, getData(18)),
      FlSpot(12, getData(17)),
      FlSpot(13, getData(16)),
      FlSpot(14, getData(15)),
      FlSpot(15, getData(14)),
      FlSpot(16, getData(13)),
      FlSpot(17, getData(12)),
      FlSpot(18, getData(11)),
      FlSpot(19, getData(10)),
      FlSpot(20, getData(9)),
      FlSpot(21, getData(8)),
      FlSpot(22, getData(7)),
      FlSpot(23, getData(6)),
      FlSpot(24, getData(5)),
      FlSpot(25, getData(4)),
      FlSpot(26, getData(3)),
      FlSpot(27, getData(2)),
      FlSpot(28, getData(1)),
      FlSpot(29, getData(0)),
    ];
  }
}
