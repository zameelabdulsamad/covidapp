import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'homeScreen.dart';
class StateScreen extends StatefulWidget {
  const StateScreen({Key key}) : super(key: key);

  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {

  String kerl="KL";

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
        title: Text("Kerala"),
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
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 26,bottom: 26,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: cardYellow,
                        state: kerl,
                        txHeading: "CONFIRMED",
                        item: "confirmed",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: cardGreen,
                        state: kerl,
                        txHeading: "RECOVERED",
                        item: "recovered",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: primaryRed,
                        state: kerl,
                        txHeading: "DECEASED",
                        item: "deceased",
                        currentDate: _selectedDay,),

                    ],
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final Color txColor;
  final String item;
  final String txHeading;
  final String state;
  final Map mapResponseInRow;
  final String date;
  final DateTime currentDate;

  const RowItem({Key key, this.txColor, this.item, this.txHeading, this.state, this.mapResponseInRow, this.date, this.currentDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Text(
            itemNumber("delta"),
            style: TextStyle(
              color: primaryText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        Text(txHeading,style: TextStyle(
          color: txColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        )),
        Text(
            itemNumber("total"),
            style: TextStyle(
              color: primaryText,
              fontSize: 14,

            )),


      ],
    );
  }

  String itemNumber(String deltaortotal) {
    if(mapResponseInRow==null)
      return 0.toString();
    else if(mapResponseInRow['$date']==null){
      return 0.toString();
    }
    else if(mapResponseInRow['$date']['$state']
    ==null){
      return 0.toString();
    }
    else if(mapResponseInRow['$date']['$state']
    ["$deltaortotal"]==null){
      return 0.toString();
    }
    else if(mapResponseInRow['$date']['$state']
    ["$deltaortotal"]["$item"]==null){
      return 0.toString();
    }

    else
      return mapResponseInRow['$date']['$state']
      ["$deltaortotal"]["$item"]
          .toString();

  }
}

