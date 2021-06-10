import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/screens/indiaScreen.dart';
import 'package:covidapp/screens/stateScreen.dart';
import 'package:covidapp/screens/vaccinationScreen.dart';
import 'package:covidapp/screens/worldWideScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../constants.dart';
import 'districtScreen.dart';
import 'homeScreen.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  String district = userDistrict;
  String stateName = userState;
  String stateCode = userStateCode;
  DateTime today = DateTime.now();

  String formatDate() {
    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(today);
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
        physics: BouncingScrollPhysics(),
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
                                        district: district,
                                        state: stateCode,
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
                                            district,
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
                                    date: today,
                                    dateInString: formatDate(),
                                    state: stateCode,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.article,
                                        color: Colors.white,
                                        size: 40,
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VaccinationScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryRed,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.medical_services_rounded,
                                          color: Colors.white,
                                          size: 40,
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
                                stateName: stateName,
                                stateCode: stateCode,
                              )));
                },
                child: Container(
                    height: maxHeight * 0.35,
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
                                    stateName,
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                                aspectRatio: 2,
                                child: StateChart(
                                  state: stateCode,
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
                              RowItem(
                                txColor: cardYellow,
                                txHeading: "CONFIRMED",
                                item: "confirmed",
                              ),
                              RowItem(
                                txColor: cardGreen,
                                txHeading: "RECOVERED",
                                item: "recovered",
                              ),
                              RowItem(
                                txColor: primaryRed,
                                txHeading: "DECEASED",
                                item: "deceased",
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
                                  Text(
                                      NumberFormat.decimalPattern().format(
                                          int.parse(WMapResponse[0]
                                                  ["todayCases"]
                                              .toString())),
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
                                      NumberFormat.decimalPattern().format(
                                          int.parse(WMapResponse[0]["cases"]
                                              .toString())),
                                      style: TextStyle(
                                        color: primaryText,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              Column(
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
                                        fontSize: 14,
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
                              Column(
                                children: [
                                  Text(
                                      NumberFormat.decimalPattern().format(
                                          int.parse(WMapResponse[0]
                                                  ["todayDeaths"]
                                              .toString())),
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
  final String dateInString;
  final DateTime date;
  final String district;

  const DistrictWeekChart(
      {Key key,
      this.state,
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
              child: FutureBuilder(
                  future: getBarGroups(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return BarChart(BarChartData(
                          barGroups: snapshot.data,
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(showTitles: false),
                          )));

                    }
                    if(snapshot.hasError){
                      return Text("fhj");
                    }
                    return Text("fdvn");;
                  }
              ))
        ],
      ),
    );
  }

  String previousDates(int x) {
    DateTime pvDate = date.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }



  Future<double> getData(int y) async {
    double _returnValue = 0;
    await FirebaseFirestore.instance
        .doc('${previousDates(y)}/$state/districts/$district')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = data == null || data['delta'] == null || data['delta']['confirmed'] == null
            ? 0
            : double.parse(data['delta']['confirmed'].toString());
      }
      else{
        _returnValue =0;
      }
    });
    return _returnValue;
  }

  Future<List<BarChartGroupData>>getBarGroups() async {
    List<double> barChartDatas = [
      await getData(6),
      await getData(5),
      await getData(4),
      await getData(3),
      await getData(2),
      await getData(1),
      await getData(0)
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
  final String dateInString;
  final DateTime date;

  const StateChart(
      {Key key,
      this.state,
      this.date,
      this.dateInString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGraphData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return LineChart(LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      barWidth: 6,
                      colors: [primaryRed],
                      spots: snapshot.data,
                      isCurved: false,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false))
                ]))
            ;
          }
          if(snapshot.hasError){
            return Text("fdj");
          }
          return Text("fdf");
        }
    );
  }

  String previousDates(int x) {
    DateTime pvDate = date.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }


  Future<double> getData(int y) async {
    double _returnValue = 0;
    await FirebaseFirestore.instance
        .doc('${previousDates(y)}/$state')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = data == null || data['delta'] == null || data['delta']['confirmed'] == null
            ? 0
            : double.parse(data['delta']['confirmed'].toString());
      }
      else{
        _returnValue =0;
      }
    });
    return _returnValue;
  }

  Future<List<FlSpot>> getGraphData() async{
    return [
      FlSpot(0, await getData(29)),
      FlSpot(1, await getData(28)),
      FlSpot(2, await getData(27)),
      FlSpot(3, await getData(26)),
      FlSpot(4, await getData(25)),
      FlSpot(5, await getData(24)),
      FlSpot(6, await getData(23)),
      FlSpot(7, await getData(22)),
      FlSpot(8, await getData(21)),
      FlSpot(9, await getData(20)),
      FlSpot(10, await getData(19)),
      FlSpot(11, await getData(18)),
      FlSpot(12, await getData(17)),
      FlSpot(13, await getData(16)),
      FlSpot(14, await getData(15)),
      FlSpot(15, await getData(14)),
      FlSpot(16, await getData(13)),
      FlSpot(17, await getData(12)),
      FlSpot(18, await getData(11)),
      FlSpot(19, await getData(10)),
      FlSpot(20, await getData(9)),
      FlSpot(21, await getData(8)),
      FlSpot(22, await getData(7)),
      FlSpot(23, await getData(6)),
      FlSpot(24, await getData(5)),
      FlSpot(25, await getData(4)),
      FlSpot(26, await getData(3)),
      FlSpot(27, await getData(2)),
      FlSpot(28, await getData(1)),
      FlSpot(29, await getData(0)),
    ];
  }

}

class RowItem extends StatelessWidget {
  final Color txColor;
  final String item;
  final String txHeading;
  final DateTime currentDate;

  const RowItem(
      {Key key,
      this.txColor,
      this.item,
      this.txHeading,
      this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        FutureBuilder(
            future: finalNumber("delta"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    NumberFormat.decimalPattern()
                        .format(int.parse(snapshot.data)),
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ));
              }
              if (snapshot.hasError) {
                return Shimmer.fromColors(
                  baseColor: shimmerbasecolor,
                  highlightColor: shimmerhighlightcolor,
                  child: Container(
                    height: 20,
                    width: maxWidth * 0.20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }
              return Shimmer.fromColors(
                baseColor: shimmerbasecolor,
                highlightColor: shimmerhighlightcolor,
                child: Container(
                  height: 20,
                  width: maxWidth * 0.20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }),
        Text(txHeading,
            style: TextStyle(
              color: txColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        FutureBuilder(
            future: finalNumber("total"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    NumberFormat.decimalPattern()
                        .format(int.parse(snapshot.data)),
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 14,
                    ));
              }
              if (snapshot.hasError) {
                return Shimmer.fromColors(
                  baseColor: shimmerbasecolor,
                  highlightColor: shimmerhighlightcolor,
                  child: Container(
                    height: 15,
                    width: maxWidth * 0.20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }
              return Shimmer.fromColors(
                baseColor: shimmerbasecolor,
                highlightColor: shimmerhighlightcolor,
                child: Container(
                  height: 15,
                  width: maxWidth * 0.20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }),
      ],
    );
  }

  Future<String> finalNumber(String deltaortotal) async {
    String abc;

    DateTime _today = DateTime.now();
    String formatDate(DateTime day) {
      var outFormatter = new DateFormat('yyyy-MM-dd');
      return outFormatter.format(day);
    }

    if (await itemNumber(deltaortotal, formatDate(_today)) == "0") {
      if (await itemNumber(
              deltaortotal, formatDate(_today.subtract(Duration(days: 1)))) ==
          "0") {
        abc = 0.toString();
      } else {
        abc = await itemNumber(
            deltaortotal, formatDate(_today.subtract(Duration(days: 1))));
      }
    } else {
      abc = await itemNumber(deltaortotal, formatDate(_today));
    }
    return abc;
  }

  Future<String> itemNumber(String deltaortotal, String date) async {
    String _returnValue = "0";
    await FirebaseFirestore.instance
        .doc('$date/TT/')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = (data == null ||
                data['$deltaortotal'] == null ||
                data['$deltaortotal']['$item'] == null)
            ? 0.toString()
            : _returnValue = data['$deltaortotal']['$item'].toString();
      } else {
        _returnValue = 0.toString();
      }
    });
    return _returnValue;
  }
}
