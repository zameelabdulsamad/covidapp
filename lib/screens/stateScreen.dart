import 'dart:convert';

import 'package:covidapp/districtList.dart';
import 'package:covidapp/screens/districtScreen.dart';
import 'package:covidapp/statesList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'homeScreen.dart';
class StateScreen extends StatefulWidget {
  final StateList state;
  const StateScreen({Key key, this.state}) : super(key: key);

  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  List<String> getDistrictList(){
    if(widget.state.stateCode=="AN"){
      return ANList;

    }
    else if(widget.state.stateCode=="AP"){
      return APList;
    }
    else if(widget.state.stateCode=="AR"){
      return ARList;
    }
    else if(widget.state.stateCode=="AS"){
      return ASList;
    }
    else if(widget.state.stateCode=="BR"){
      return BRList;
    }
    else if(widget.state.stateCode=="CH"){
      return CHList;
    }
    else if(widget.state.stateCode=="CT"){
      return CTList;
    }
    else if(widget.state.stateCode=="DL"){
      return DLList;
    }
    else if(widget.state.stateCode=="DN"){
      return DNList;
    }
    else if(widget.state.stateCode=="GA"){
      return GAList;
    }
    else if(widget.state.stateCode=="GJ"){
      return GJList;
    }
    else if(widget.state.stateCode=="HP"){
      return HPList;
    }
    else if(widget.state.stateCode=="HR"){
      return HRList;
    }
    else if(widget.state.stateCode=="JH"){
      return JHList;
    }
    else if(widget.state.stateCode=="JK"){
      return JKList;
    }
    else if(widget.state.stateCode=="KA"){
      return KAList;
    }
    else if(widget.state.stateCode=="KL"){
      return KLList;
    }
    else if(widget.state.stateCode=="LA"){
      return LAList;
    }
    else if(widget.state.stateCode=="LD"){
      return LDList;
    }
    else if(widget.state.stateCode=="MH"){
      return MHList;
    }
    else if(widget.state.stateCode=="ML"){
      return MLList;
    }
    else if(widget.state.stateCode=="MN"){
      return MNList;
    }
    else if(widget.state.stateCode=="MP"){
      return MPList;
    }
    else if(widget.state.stateCode=="MZ"){
      return MZList;
    }
    else if(widget.state.stateCode=="NL"){
      return NLList;
    }
    else if(widget.state.stateCode=="OR"){
      return ORList;
    }
    else if(widget.state.stateCode=="PB"){
      return PBList;
    }
    else if(widget.state.stateCode=="PY"){
      return PYList;
    }
    else if(widget.state.stateCode=="RJ"){
      return RJList;
    }
    else if(widget.state.stateCode=="SK"){
      return SKList;
    }
    else if(widget.state.stateCode=="TG"){
      return TGList;
    }
    else if(widget.state.stateCode=="TN"){
      return TNList;
    }
    else if(widget.state.stateCode=="TR"){
      return TRList;
    }
    else if(widget.state.stateCode=="UP"){
      return UPList;
    }
    else if(widget.state.stateCode=="UT"){
      return UTList;
    }
    else if(widget.state.stateCode=="WB"){
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
    return Scaffold(
        appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text(widget.state.stateName),
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
                        state: widget.state.stateCode,
                        txHeading: "CONFIRMED",
                        item: "confirmed",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: cardGreen,
                        state: widget.state.stateCode,
                        txHeading: "RECOVERED",
                        item: "recovered",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: primaryRed,
                        state: widget.state.stateCode,
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
                      itemCount: getDistrictList().length,

                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new StateCard(date: formatDate(),
                            mapResponse: mapResponse,
                            state: widget.state.stateCode,
                            district: getDistrictList()[index],
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DistrictScreen(state: widget.state.stateCode,district: getDistrictList()[index],)));},

                            item: getDistrictList()[index],),
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


  final String district;
  final String state;
  final VoidCallback onTap;
  final String item;
  final bool selected;
  final String date;
  final Map mapResponse;
  const StateCard({Key key, this.district, this.onTap, this.item, this.selected, this.date, this.mapResponse, this.state}) : super(key: key);

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
    else if(mapResponse['$date']['$state']
        ==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['$state']
    ['districts']==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['$state']
    ['districts']['$district']==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['$state']
    ['districts']['$district']["delta"]==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['$state']
    ['districts']['$district']["delta"]["confirmed"]==null){
      return 0.toString();
    }

    else
      return mapResponse['$date']['$state']
      ['districts']['$district']["delta"]["confirmed"]
          .toString();

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
