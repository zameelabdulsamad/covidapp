import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/screens/homeScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
class VaccinationDistrictScreen extends StatefulWidget {
  final String district;
  final String state;
  const VaccinationDistrictScreen({Key key, this.district, this.state}) : super(key: key);
  @override
  _VaccinationDistrictScreenState createState() => _VaccinationDistrictScreenState();
}

class _VaccinationDistrictScreenState extends State<VaccinationDistrictScreen> {
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
        title: Text(widget.district),
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
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Container(
                  height: maxHeight*0.35,
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
                                      fontSize: 18,
                                      color: primaryText),
                                ),
                                FutureBuilder(
                                    future: getTotalVAC(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        return Text(
                                          NumberFormat.decimalPattern().format(int.parse(snapshot.data)),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: primaryText,
                                              fontWeight: FontWeight.bold),

                                        )


                                        ;
                                      }
                                      if(snapshot.hasError){
                                        return Text("dfsdfs");
                                      }
                                      return Text("dfs");
                                    }
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
                                state: widget.state,
                                district: widget.district,
                                dateInString: formatDate(),
                                date: _selectedDay,
                              )),
                        ),
                      ),
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
        .doc('${formatDate()}/${widget.state}/districts/${widget.district}')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = data == null || data['total'] == null || data['total']['vaccinated2'] == null
            ? "0"
            : data['total']['vaccinated2'].toString();
      }
      else{
        _returnValue ="0";
      }
    });
    return _returnValue;
  }

}



class StateChart extends StatelessWidget {
  final String district;
  final String state;
  final String dateInString;
  final DateTime date;

  const StateChart(
      {Key key,
        this.state,
        this.date,
        this.dateInString, this.district})
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
            return Text("dfsdfs");
          }
          return Text("dfs");
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
        .doc('${previousDates(y)}/$state/districts/$district')
        .get()
        .then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue = data == null || data['total'] == null || data['total']['vaccinated2'] == null
            ? 0
            : double.parse(data['total']['vaccinated2'].toString());
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




