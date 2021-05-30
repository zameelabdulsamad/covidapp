import 'package:covidapp/statesList.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
  int getIndex(){
    DateTime _today=DateTime.now();
    var outFormatter = new DateFormat('yyyy-MM-dd');
    for(int i=0;i<listResponse.length;i++){
      if(listResponse[i]["dateymd"].toString()==outFormatter.format(_selectedDay))
        return i;
      else if(outFormatter.format(_today)==outFormatter.format(_selectedDay)){
        return (listResponse.length-1);
      }
    }
  }
  String getData(String item){

    return listResponse[getIndex()]["$item"];




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
                      Column(
                        children: [
                          Text(
                              getData("dailyconfirmed"),
                              style: TextStyle(
                                color: primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("CONFIRMED",style: TextStyle(
                            color: cardYellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                          Text(getData("totalconfirmed")
                              ,
                              style: TextStyle(
                                color: primaryText,
                                fontSize: 14,

                              )),


                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            getData("dailyrecovered"),
                              style: TextStyle(
                                color: primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("RECOVERED",style: TextStyle(
                            color: cardGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                          Text(
                              getData("totalrecovered"),
                              style: TextStyle(
                                color: primaryText,
                                fontSize: 14,

                              )),


                        ],
                      ),
                  Column(
                    children: [
                      Text(
                        getData("dailydeceased"),
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("DECEASED",style: TextStyle(
                        color: primaryRed,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                      Text(
                          getData("totaldeceased"),
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 16),
              child: Container(
                width: double.infinity,
                height: 2000,


                decoration: BoxDecoration(
                  color: bgGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: new ListView.builder
                  (
                   physics: const NeverScrollableScrollPhysics(),
                    itemCount: stateList.length,

                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new StateCard(date: formatDate(),
                          mapResponse: mapResponse,
                          state: stateList[index],
                          item: stateList[index],),
                      );
                    }
                )

              ),
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
  final Map mapResponse;
  const StateCard({Key key, this.state, this.onTap, this.item, this.selected, this.date, this.mapResponse}) : super(key: key);

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
                    Text(
                      itemNumber().toString(),
                      style: null,
                      textAlign: TextAlign.left,
                    ),
                    Icon(Icons.arrow_forward_ios,color: primaryRed,size: 16,)

                  ],
                )



              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )),
    );
  }

  String itemNumber() {
    if(mapResponse==null)
      return 0.toString();
    else if(mapResponse['$date']==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['${state.stateCode}']
        ==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['${state.stateCode}']
    ["delta"]==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['${state.stateCode}']
    ["delta"]["confirmed"]==null){
      return 0.toString();
    }

    else
      return mapResponse['$date']['${state.stateCode}']
      ["delta"]["confirmed"]
          .toString();

  }
}




