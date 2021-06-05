import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'homeScreen.dart';

class DistrictScreen extends StatefulWidget {
  final String district;
  final String state;
  const DistrictScreen({Key key, this.district, this.state}) : super(key: key);

  @override
  _DistrictScreenState createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {


  String formatDate() {
    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(_selectedDay);
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();





  @override
  Widget build(BuildContext context) {
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
            DataCard(
              district: widget.district,
              mapResponseInCard: mapResponse,
              date: formatDate(),
              cardColor: cardYellow,
              graphColor: Color(0xFFC7971D),
              state: widget.state,
              cardHeading: "CONFIRMED CASES",
              item: "confirmed",
              currentDate: _selectedDay,
            ),
            DataCard(
              district: widget.district,
              mapResponseInCard: mapResponse,
              date: formatDate(),
              cardColor: cardGreen,
              graphColor: Color(0xFF27905D),
              state: widget.state,

              cardHeading: "RECOVERED CASES",
              item: "recovered",
              currentDate: _selectedDay,
            ),
            DataCard(
              district: widget.district,
              mapResponseInCard: mapResponse,
              date: formatDate(),
              graphColor: Color(0xFFA22C29),
              state: widget.state,

              cardColor: primaryRed,
              cardHeading: "DECEASED",
              item: "deceased",
              currentDate: _selectedDay,
            ),
          ],
        ),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  final Color cardColor;
  final Color graphColor;

  final String item;
  final String cardHeading;
  final String district;
  final String state;
  final Map mapResponseInCard;
  final String date;
  final DateTime currentDate;

  const DataCard(
      {Key key,
      this.cardColor,
      this.cardHeading,
      this.district,
      this.mapResponseInCard,
      this.date,
      this.item,
      this.currentDate,
      this.graphColor,
      this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
        child: Container(
          height: maxHeight*0.2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    cardHeading,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      NumberFormat.decimalPattern().format(int.parse(itemNumber("delta")))

                      ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: maxHeight*0.1,
                    child: LineChart(LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                              barWidth: 6,
                              colors: [graphColor],
                              spots: getGraphData(),
                              isCurved: false,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false))
                        ])),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      "Total till Date",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:Text( NumberFormat.decimalPattern().format(int.parse(itemNumber("total")))

                          ,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                  )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String previousDates(int x) {
    DateTime pvDate = currentDate.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }

  double getData(int y) {
    if(mapResponseInCard==null)
      return 0;
    else if(mapResponseInCard['${previousDates(y)}']==null){
      return 0;
    }
    else if(mapResponseInCard['${previousDates(y)}']['$state']
        ==null){
      return 0;
    }
    else if(mapResponseInCard['${previousDates(y)}']['$state']
    ['districts']==null){
      return 0;
    }
    else if(mapResponseInCard['${previousDates(y)}']['$state']
    ['districts']['$district']==null){
      return 0;
    }

    else if(mapResponseInCard['${previousDates(y)}']['$state']
    ['districts']['$district']["delta"]==null){
      return 0;
    }
    else if(mapResponseInCard['${previousDates(y)}']['$state']
    ['districts']['$district']["delta"]["$item"]==null){
      return 0;
    }

    else
      return double.parse(mapResponseInCard['${previousDates(y)}']['$state']
      ['districts']['$district']["delta"]["$item"]
          .toString());
  }
  String itemNumber(String deltaortotal) {
    if(mapResponseInCard==null)
      return 0.toString();
    else if(mapResponseInCard['$date']==null){
      return 0.toString();
    }
    else if(mapResponseInCard['$date']['$state']
        ==null){
      return 0.toString();
    }
    else if(mapResponseInCard['$date']['$state']
    ['districts']==null){
      return 0.toString();
    }
    else if(mapResponseInCard['$date']['$state']
    ['districts']['$district']==null){
      return 0.toString();
    }
    else if(mapResponseInCard['$date']['$state']
    ['districts']['$district']["$deltaortotal"]==null){
      return 0.toString();
    }
    else if(mapResponseInCard['$date']['$state']
    ['districts']['$district']["$deltaortotal"]["$item"]==null){
      return 0.toString();
    }

    else
      return mapResponseInCard['$date']['$state']
      ['districts']['$district']["$deltaortotal"]["$item"]
          .toString();

  }

  List<FlSpot> getGraphData() {
    return [
      FlSpot(0, getData(6)),
      FlSpot(1, getData(5)),
      FlSpot(2, getData(4)),
      FlSpot(3, getData(3)),
      FlSpot(4, getData(2)),
      FlSpot(5, getData(1)),
      FlSpot(6, getData(0)),
    ];
  }
}
