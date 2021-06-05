import 'dart:convert';

import 'package:covidapp/districtList.dart';
import 'package:covidapp/screens/districtScreen.dart';
import 'package:covidapp/statesList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'homeScreen.dart';
class StateScreen extends StatefulWidget {
  final String stateName;
  final String stateCode;

  const StateScreen({Key key,  this.stateName, this.stateCode}) : super(key: key);

  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  List<DistrictCodeList> getDistrictList(){
    if(widget.stateCode=="AN"){
      return ANList;

    }
    else if(widget.stateCode=="AP"){
      return APList;
    }
    else if(widget.stateCode=="AR"){
      return ARList;
    }
    else if(widget.stateCode=="AS"){
      return ASList;
    }
    else if(widget.stateCode=="BR"){
      return BRList;
    }
    else if(widget.stateCode=="CH"){
      return CHList;
    }
    else if(widget.stateCode=="CT"){
      return CTList;
    }
    else if(widget.stateCode=="DL"){
      return DLList;
    }
    else if(widget.stateCode=="DN"){
      return DNList;
    }
    else if(widget.stateCode=="GA"){
      return GAList;
    }
    else if(widget.stateCode=="GJ"){
      return GJList;
    }
    else if(widget.stateCode=="HP"){
      return HPList;
    }
    else if(widget.stateCode=="HR"){
      return HRList;
    }
    else if(widget.stateCode=="JH"){
      return JHList;
    }
    else if(widget.stateCode=="JK"){
      return JKList;
    }
    else if(widget.stateCode=="KA"){
      return KAList;
    }
    else if(widget.stateCode=="KL"){
      return KLList;
    }
    else if(widget.stateCode=="LA"){
      return LAList;
    }
    else if(widget.stateCode=="LD"){
      return LDList;
    }
    else if(widget.stateCode=="MH"){
      return MHList;
    }
    else if(widget.stateCode=="ML"){
      return MLList;
    }
    else if(widget.stateCode=="MN"){
      return MNList;
    }
    else if(widget.stateCode=="MP"){
      return MPList;
    }
    else if(widget.stateCode=="MZ"){
      return MZList;
    }
    else if(widget.stateCode=="NL"){
      return NLList;
    }
    else if(widget.stateCode=="OR"){
      return ORList;
    }
    else if(widget.stateCode=="PB"){
      return PBList;
    }
    else if(widget.stateCode=="PY"){
      return PYList;
    }
    else if(widget.stateCode=="RJ"){
      return RJList;
    }
    else if(widget.stateCode=="SK"){
      return SKList;
    }
    else if(widget.stateCode=="TG"){
      return TGList;
    }
    else if(widget.stateCode=="TN"){
      return TNList;
    }
    else if(widget.stateCode=="TR"){
      return TRList;
    }
    else if(widget.stateCode=="UP"){
      return UPList;
    }
    else if(widget.stateCode=="UT"){
      return UTList;
    }
    else if(widget.stateCode=="WB"){
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
    int tested=int.parse(tpValues("tested"));
    int confirmed=int.parse(tpValues("confirmed"));
    double tppercent=tested==0||confirmed==0?0:(confirmed/tested);

    return Scaffold(
        appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text(widget.stateName),
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
                        state: widget.stateCode,
                        txHeading: "CONFIRMED",
                        item: "confirmed",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: cardGreen,
                        state: widget.stateCode,
                        txHeading: "RECOVERED",
                        item: "recovered",
                        currentDate: _selectedDay,),
                      RowItem(
                        mapResponseInRow: mapResponse,
                        date: formatDate(),
                        txColor: primaryRed,
                        state: widget.stateCode,
                        txHeading: "DECEASED",
                        item: "deceased",
                        currentDate: _selectedDay,),

                    ],
                  ),
                ),
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
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
                              padding:
                              const EdgeInsets.only(top: 8, bottom: 16, left: 16),
                              child: new CircularPercentIndicator(
                                radius: 110.0,
                                lineWidth: 30.0,
                                percent: tppercent,
                                center: new Text(
                                  "${(tppercent*100).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryText,
                                      fontSize: 12),
                                ),
                                progressColor: primaryRed,
                                backgroundColor: iconGrey,
                                circularStrokeCap: CircularStrokeCap.butt,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total Tested",
                                    style: TextStyle(fontSize: 14, color: primaryText),
                                  ),
                                  Text(
                                    NumberFormat.decimalPattern().format(int.parse(tpValues("tested")))
                                    ,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: primaryText,
                                        fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 16),
              child: Container(
                  width: double.infinity,


                  decoration: BoxDecoration(
                    color: bgGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15,left: 20,right: 15,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("District",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Confirmed",style: TextStyle(fontWeight: FontWeight.bold),),



                          ],
                        ),
                      ),
                      new ListView.builder
                        (
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getDistrictList().length,
                          shrinkWrap: true,

                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new StateCard(date: formatDate(),
                                mapResponse: mapResponse,
                                state: widget.stateCode,
                                district: getDistrictList()[index].districtName,
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DistrictScreen(state: widget.stateCode,district: getDistrictList()[index].districtName,)));},

                                item: getDistrictList()[index].districtName,),
                            );
                          }
                      ),
                    ],
                  )

              ),
            ),


          ],
        ),
      ),
    );
  }

  String tpValues(String item) {
    if(mapResponse==null)
      return 0.toString();
    else if(mapResponse['${formatDate()}']==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.stateCode}']
        ==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.stateCode}']
    ["delta"]==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.stateCode}']
    ["delta"]["$item"]==null){
      return 0.toString();
    }

    else
      return mapResponse['${formatDate()}']['${widget.stateCode}']
      ["delta"]["$item"]
          .toString();

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
                      NumberFormat.decimalPattern().format(int.parse(itemNumber())),

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


    NumberFormat.decimalPattern().format(int.parse(itemNumber("delta"))),
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
            NumberFormat.decimalPattern().format(int.parse(itemNumber("total"))),


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
