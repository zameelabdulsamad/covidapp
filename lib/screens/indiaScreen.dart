import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/screens/stateScreen.dart';
import 'package:covidapp/statesList.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'homeScreen.dart';

class IndiaScreen extends StatefulWidget {
  const IndiaScreen({Key key}) : super(key: key);

  @override
  _IndiaScreenState createState() => _IndiaScreenState();
}

class _IndiaScreenState extends State<IndiaScreen> {
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 26, bottom: 26, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RowItem(
                        date: formatDate(),
                        txColor: cardYellow,
                        state: "TT",
                        txHeading: "CONFIRMED",
                        item: "confirmed",
                        currentDate: _selectedDay,
                      ),
                      RowItem(
                        date: formatDate(),
                        txColor: cardGreen,
                        state: "TT",
                        txHeading: "RECOVERED",
                        item: "recovered",
                        currentDate: _selectedDay,
                      ),
                      RowItem(
                        date: formatDate(),
                        txColor: primaryRed,
                        state: "TT",
                        txHeading: "DECEASED",
                        item: "deceased",
                        currentDate: _selectedDay,
                      ),
                    ],
                  ),
                ),
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
                              "Confirmed",
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
                                          builder: (context) => StateScreen(
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
}

class StateCard extends StatelessWidget {
  final StateList state;
  final VoidCallback onTap;
  final StateList item;
  final bool selected;
  final String date;

  const StateCard(
      {Key key,
      this.state,
      this.onTap,
      this.item,
      this.selected,
      this.date,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    // if (selected)
    //   textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
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
            padding: const EdgeInsets.all(10.0),
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
                    FutureBuilder(
                        future: itemNumber(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              NumberFormat.decimalPattern()
                                  .format(int.parse(snapshot.data)),
                              style: null,
                              textAlign: TextAlign.left,
                            )

                            ;
                          }
                          if (snapshot.hasError) {
                            return Text("dfsdfs");
                          }
                          return Text("dfs");
                        }),
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
        _returnValue = (data == null ||
            data['delta'] == null ||
            data['delta']['confirmed'] == null)
            ? 0.toString()
            : _returnValue = data['delta']['confirmed'].toString();
      } else {
        _returnValue = 0.toString();
      }
    });
    return _returnValue;
  }
}

class RowItem extends StatelessWidget {
  final Color txColor;
  final String item;
  final String txHeading;
  final String state;
  final String date;
  final DateTime currentDate;

  const RowItem(
      {Key key,
      this.txColor,
      this.item,
      this.txHeading,
      this.state,
      this.date,
      this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        FutureBuilder(
            future: itemNumber("delta"),
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
            future: itemNumber("total"),
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

  Future<String> itemNumber(String deltaortotal) async {
    String _returnValue = "0";
    await FirebaseFirestore.instance
        .doc('$date/$state')
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
