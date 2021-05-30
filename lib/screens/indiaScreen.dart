import 'package:covidapp/screens/stateScreen.dart';
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
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: cardYellow,

                        txHeading: "CONFIRMED",
                        item: "confirmed",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: cardGreen,

                        txHeading: "RECOVERED",
                        item: "recovered",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: primaryRed,

                        txHeading: "DECEASED",
                        item: "deceased",
                        currentDate: _selectedDay,),

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
                          onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => StateScreen(state: stateList[index])));},
    
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

class RowItem extends StatelessWidget {
  final Color txColor;
  final String item;
  final String txHeading;
  final Map mapResponseInRow;
  final String date;
  final DateTime currentDate;

  const RowItem({Key key, this.txColor, this.item, this.txHeading,  this.mapResponseInRow, this.date, this.currentDate}) : super(key: key);

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
    else if(mapResponseInRow['$date']['TT']
        ==null){
      return 0.toString();
    }
    else if(mapResponseInRow['$date']['TT']
    ["$deltaortotal"]==null){
      return 0.toString();
    }
    else if(mapResponseInRow['$date']['TT']
    ["$deltaortotal"]["$item"]==null){
      return 0.toString();
    }

    else
      return mapResponseInRow['$date']['TT']
      ["$deltaortotal"]["$item"]
          .toString();

  }
}




