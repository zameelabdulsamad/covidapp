import 'package:covidapp/constants.dart';
import 'package:covidapp/districtList.dart';
import 'package:covidapp/screens/homeScreen.dart';
import 'package:covidapp/screens/vaccinationDistrictScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'districtScreen.dart';
class VaccinationStateScreen extends StatefulWidget {
  final String stateName;
  final String stateCode;

  const VaccinationStateScreen({Key key,  this.stateName, this.stateCode}) : super(key: key);

  @override
  _VaccinationStateScreenState createState() => _VaccinationStateScreenState();
}

class _VaccinationStateScreenState extends State<VaccinationStateScreen> {
  List<String> getDistrictList(){
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
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Container(
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
                                  "Total Vaccinated",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: primaryText),
                                ),
                                Text(
                                  getTotalVAC(),
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
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Expanded(
                          child: AspectRatio(
                              aspectRatio: 2,
                              child: StateChart(
                                mapResponseInCard: mapResponse,
                                state: widget.stateCode,
                                dateInString: formatDate(),
                                date: _selectedDay,
                              )),
                        ),
                      ),
                    ],
                  )),
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
                            state: widget.stateCode,
                            district: getDistrictList()[index],
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VaccinationDistrictScreen(state: widget.stateCode,district: getDistrictList()[index],)));},



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

  String getTotalVAC() {

     if(mapResponse
        ==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.stateCode}']
    ==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.stateCode}']
    ["total"]==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.stateCode}']
    ["total"]["vaccinated"]==null){
      return 0.toString();
    }

    else
      return mapResponse['${formatDate()}']['${widget.stateCode}']
      ["total"]["vaccinated"]
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
    ['districts']['$district']["total"]==null){
      return 0.toString();
    }
    else if(mapResponse['$date']['$state']
    ['districts']['$district']["total"]["vaccinated"]==null){
      return 0.toString();
    }

    else
      return mapResponse['$date']['$state']
      ['districts']['$district']["total"]["vaccinated"]
          .toString();

  }


}

class StateChart extends StatelessWidget {
  final String state;
  final Map mapResponseInCard;
  final String dateInString;
  final DateTime date;

  const StateChart(
      {Key key,
        this.state,
        this.mapResponseInCard,
        this.date,
        this.dateInString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
              barWidth: 6,
              colors: [primaryRed],
              spots: getGraphData(),
              isCurved: false,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false))
        ]));
  }

  String previousDates(int x) {
    DateTime pvDate = date.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }

  double getData(int y) {
    if (mapResponseInCard == null)
      return 0;
    else if (mapResponseInCard['${previousDates(y)}'] == null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state'] == null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']["total"] ==
        null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']["total"]
    ["vaccinated"] ==
        null) {
      return 0;
    } else
      return double.parse(mapResponseInCard['${previousDates(y)}']['$state']
      ["total"]["vaccinated"]
          .toString());
  }

  List<FlSpot> getGraphData() {
    return [
      FlSpot(0, getData(29)),
      FlSpot(1, getData(28)),
      FlSpot(2, getData(27)),
      FlSpot(3, getData(26)),
      FlSpot(4, getData(25)),
      FlSpot(5, getData(24)),
      FlSpot(6, getData(23)),
      FlSpot(7, getData(22)),
      FlSpot(8, getData(21)),
      FlSpot(9, getData(20)),
      FlSpot(10, getData(19)),
      FlSpot(11, getData(18)),
      FlSpot(12, getData(17)),
      FlSpot(13, getData(16)),
      FlSpot(14, getData(15)),
      FlSpot(15, getData(14)),
      FlSpot(16, getData(13)),
      FlSpot(17, getData(12)),
      FlSpot(18, getData(11)),
      FlSpot(19, getData(10)),
      FlSpot(20, getData(9)),
      FlSpot(21, getData(8)),
      FlSpot(22, getData(7)),
      FlSpot(23, getData(6)),
      FlSpot(24, getData(5)),
      FlSpot(25, getData(4)),
      FlSpot(26, getData(3)),
      FlSpot(27, getData(2)),
      FlSpot(28, getData(1)),
      FlSpot(29, getData(0)),
    ];
  }
}



