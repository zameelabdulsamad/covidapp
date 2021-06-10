import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/districtList.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/screens/districtScreen.dart';
import 'package:covidapp/statesList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'homeScreen.dart';

class StateScreen extends StatefulWidget {
  final String stateName;
  final String stateCode;

  const StateScreen({Key key, this.stateName, this.stateCode})
      : super(key: key);

  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  List<DistrictCodeList> getDistrictList() {
    if (widget.stateCode == "AN") {
      return ANList;
    } else if (widget.stateCode == "AP") {
      return APList;
    } else if (widget.stateCode == "AR") {
      return ARList;
    } else if (widget.stateCode == "AS") {
      return ASList;
    } else if (widget.stateCode == "BR") {
      return BRList;
    } else if (widget.stateCode == "CH") {
      return CHList;
    } else if (widget.stateCode == "CT") {
      return CTList;
    } else if (widget.stateCode == "DL") {
      return DLList;
    } else if (widget.stateCode == "DN") {
      return DNList;
    } else if (widget.stateCode == "GA") {
      return GAList;
    } else if (widget.stateCode == "GJ") {
      return GJList;
    } else if (widget.stateCode == "HP") {
      return HPList;
    } else if (widget.stateCode == "HR") {
      return HRList;
    } else if (widget.stateCode == "JH") {
      return JHList;
    } else if (widget.stateCode == "JK") {
      return JKList;
    } else if (widget.stateCode == "KA") {
      return KAList;
    } else if (widget.stateCode == "KL") {
      return KLList;
    } else if (widget.stateCode == "LA") {
      return LAList;
    } else if (widget.stateCode == "LD") {
      return LDList;
    } else if (widget.stateCode == "MH") {
      return MHList;
    } else if (widget.stateCode == "ML") {
      return MLList;
    } else if (widget.stateCode == "MN") {
      return MNList;
    } else if (widget.stateCode == "MP") {
      return MPList;
    } else if (widget.stateCode == "MZ") {
      return MZList;
    } else if (widget.stateCode == "NL") {
      return NLList;
    } else if (widget.stateCode == "OR") {
      return ORList;
    } else if (widget.stateCode == "PB") {
      return PBList;
    } else if (widget.stateCode == "PY") {
      return PYList;
    } else if (widget.stateCode == "RJ") {
      return RJList;
    } else if (widget.stateCode == "SK") {
      return SKList;
    } else if (widget.stateCode == "TG") {
      return TGList;
    } else if (widget.stateCode == "TN") {
      return TNList;
    } else if (widget.stateCode == "TR") {
      return TRList;
    } else if (widget.stateCode == "UP") {
      return UPList;
    } else if (widget.stateCode == "UT") {
      return UTList;
    } else if (widget.stateCode == "WB") {
      return WBList;
    }
  }

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
    double maxWidth = MediaQuery.of(context).size.width;




    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text(widget.stateName),
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
                        state: widget.stateCode,
                        txHeading: "CONFIRMED",
                        item: "confirmed",
                        currentDate: _selectedDay,
                      ),
                      RowItem(
                        date: formatDate(),
                        txColor: cardGreen,
                        state: widget.stateCode,
                        txHeading: "RECOVERED",
                        item: "recovered",
                        currentDate: _selectedDay,
                      ),
                      RowItem(
                        date: formatDate(),
                        txColor: primaryRed,
                        state: widget.stateCode,
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
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Container(
                  decoration: BoxDecoration(
                    color: bgGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10, bottom: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Test Positivity",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 16, left: 16),
                              child: FutureBuilder(
                                  future: getPercent(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      return new CircularPercentIndicator(
                                        radius: 110.0,
                                        lineWidth: 30.0,
                                        percent: snapshot.data,
                                        center: new Text(
                                          "${(snapshot.data * 100).toStringAsFixed(1)}%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryText,
                                              fontSize: 12),
                                        ),
                                        progressColor: primaryRed,
                                        backgroundColor: iconGrey,
                                        circularStrokeCap: CircularStrokeCap.butt,
                                      );


                                    ;
                                    }
                                    if(snapshot.hasError){
                                      return  Shimmer.fromColors(
                                        baseColor: shimmerbasecolor,
                                        highlightColor: shimmerhighlightcolor,
                                        child:
                                        Container(
                                          height: maxHeight*0.15,
                                          width: maxWidth*0.3,
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
                                      child:
                                      Container(
                                        height: maxHeight*0.15,
                                        width: maxWidth*0.3,
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
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total Tested",
                                    style: TextStyle(
                                        fontSize: 14, color: primaryText),
                                  ),
                                  FutureBuilder(
                                      future: tpValues(
                                          "tested"),
                                      builder: (context, snapshot) {
                                        if(snapshot.hasData){
                                          return Text(
                                            NumberFormat.decimalPattern()
                                                .format(int.parse(snapshot.data)),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: primaryText,
                                                fontWeight: FontWeight.bold),
                                          )

                                          ;
                                        }
                                        if(snapshot.hasError){
                                          return Shimmer.fromColors(
                                            baseColor: shimmerbasecolor,
                                            highlightColor: shimmerhighlightcolor,
                                            child:
                                            Container(
                                              height: 20,
                                              width: maxWidth*0.20,
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
                                          child:
                                          Container(
                                            height: 20,
                                            width: maxWidth*0.20,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),


                                        );
                                      }
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
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
                              "District",
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
                          itemCount: getDistrictList().length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new StateCard(
                                date: formatDate(),
                                state: widget.stateCode,
                                district: getDistrictList()[index].districtName,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DistrictScreen(
                                                state: widget.stateCode,
                                                district:
                                                    getDistrictList()[index]
                                                        .districtName,
                                              )));
                                },
                                item: getDistrictList()[index].districtName,
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


  Future<double> getPercent() async{
    double percent;
    String tested = await tpValues("tested");
    int testedinInt = int.parse(tested);
    String confirmed = await tpValues("confirmed");
    int confirmedinInt = int.parse(confirmed);
    percent = testedinInt == 0 || confirmedinInt == 0 ? 0 : (confirmedinInt / testedinInt);
    return percent;


  }

  Future<String> tpValues(String item) async{
    String _returnValue="0";
    await FirebaseFirestore.instance
        .doc('${formatDate()}/${widget.stateCode}')
        .get().then((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        _returnValue=(data == null ||data['delta'] == null||data['delta']['$item'] == null)?0.toString():_returnValue=data['delta']['$item'].toString();


      }
      else{

        _returnValue=0.toString();
      }
    });
    return _returnValue;
  }







}

class StateCard extends StatelessWidget {
  final String district;
  final String state;
  final VoidCallback onTap;
  final String item;
  final bool selected;
  final String date;

  const StateCard(
      {Key key,
      this.district,
      this.onTap,
      this.item,
      this.selected,
      this.date,
      this.state})
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
                  district,
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
        .doc('$date/$state/districts/$district')
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
                return Text("dfsdfs");
              }
              return Text("dfs");
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
                    NumberFormat.decimalPattern().format(
                      int.parse(snapshot.data),
                    ),
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 14,
                    ));
              }
              if (snapshot.hasError) {
                return Text("dfsdfs");
              }
              return Text("dfs");
            }),
      ],
    );
  }

  Future<String> itemNumber(String deltaortotal) async {
    String _returnValue = "0";
    await FirebaseFirestore.instance
        .doc('$date/$state/')
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
