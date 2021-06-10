import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/screens/homeScreen.dart';
import 'package:covidapp/screens/vaccinationStateScreen.dart';
import 'package:covidapp/statesList.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class VaccinationIndiaScreen extends StatefulWidget {
  const VaccinationIndiaScreen({Key key}) : super(key: key);

  @override
  _VaccinationIndiaScreenState createState() => _VaccinationIndiaScreenState();
}

class _VaccinationIndiaScreenState extends State<VaccinationIndiaScreen> {
  String formatDate() {
    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(_selectedDay);
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text("India"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 01, 30),
                    lastDay: DateTime.now(),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: FutureBuilder(
                  future: getValues(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Container(
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
                                          "Vaccinated both",
                                          style: TextStyle(
                                              fontSize: 18, color: primaryText),
                                        ),
                                        Text(
                                          NumberFormat.decimalPattern()
                                              .format(int.parse(snapshot.data["data"])),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: primaryText,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                      aspectRatio: 2,
                                      child: StateChart(
                                        graph: snapshot.data["graph"],
                                      )),
                                ),
                              ),
                            ],
                          ))


                      ;
                    }
                    if(snapshot.hasError){
                      return Shimmer.fromColors(
                        baseColor: shimmerbasecolor,
                        highlightColor: shimmerhighlightcolor,
                        child: Container(
                          height: maxHeight * 0.35,
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
                        height: maxHeight * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
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
                            top: 15, left: 20, right: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "State",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Vaccinated",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      new ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: stateList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new StateCard(
                                date: formatDate(),
                                state: stateList[index],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VaccinationStateScreen(
                                                stateCode:
                                                    stateList[index].stateCode,
                                                stateName:
                                                    stateList[index].stateName,
                                              )));
                                },
                                item: stateList[index],
                              ),
                            );
                          }),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getTotalVAC() async {
    String _returnValue = "0";
    await FirebaseFirestore.instance
        .doc('${formatDate()}/TT')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = data == null ||
                data['total'] == null ||
                data['total']['vaccinated2'] == null
            ? "0"
            : data['total']['vaccinated2'].toString();
      } else {
        _returnValue = "0";
      }
    });
    return _returnValue;
  }

  String previousDates(int x) {
    DateTime pvDate = _selectedDay.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }

  Future<double> getData(int y) async {
    double _returnValue = 0;
    await FirebaseFirestore.instance
        .doc('${previousDates(y)}/TT')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = data == null ||
            data['total'] == null ||
            data['total']['vaccinated2'] == null
            ? 0
            : double.parse(data['total']['vaccinated2'].toString());
      } else {
        _returnValue = 0;
      }
    });
    return _returnValue;
  }

  Future<List<FlSpot>> getGraphData() async {
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

  Future<Map> getValues() async{
    Map abc={
      "data":await getTotalVAC(),
      "graph":await getGraphData()

    };
    return abc;
  }


}

class StateCard extends StatelessWidget {
  final StateList state;
  final VoidCallback onTap;
  final StateList item;
  final bool selected;
  final String date;

  const StateCard(
      {Key key, this.onTap, this.item, this.selected, this.date, this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    // if (selected)
    //   textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return FutureBuilder(
        future: itemNumber(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return InkWell(
              onTap: () {
                onTap();
              },
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgWhite,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          state.stateName,
                          style: null,
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Text(
                              NumberFormat.decimalPattern()
                                  .format(int.parse(snapshot.data)),
                              style: null,
                              textAlign: TextAlign.left,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: primaryRed,
                              size: 16,
                            )
                          ],
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  )),
            )


            ;
          }
          if(snapshot.hasError){
            return Shimmer.fromColors(
              baseColor: shimmerbasecolor,
              highlightColor: shimmerhighlightcolor,
              child: Container(
                height:40,
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
              height:40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
    );
  }

  Future<String> itemNumber() async {
    String _returnValue = "0";
    await FirebaseFirestore.instance
        .doc('$date/${state.stateCode}')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = data == null ||
                data['total'] == null ||
                data['total']['vaccinated2'] == null
            ? "0"
            : data['total']['vaccinated2'].toString();
      } else {
        _returnValue = "0";
      }
    });
    return _returnValue;
  }
}

class StateChart extends StatelessWidget {
  final List<FlSpot> graph;

  const StateChart({Key key, this.graph, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  LineChart(LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      barWidth: 6,
                      colors: [primaryRed],
                      spots: graph,
                      isCurved: false,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false))
                ]));
  }


}
