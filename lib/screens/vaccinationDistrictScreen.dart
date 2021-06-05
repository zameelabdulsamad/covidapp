import 'package:covidapp/constants.dart';
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
                                Text(
                                    NumberFormat.decimalPattern().format(int.parse(getTotalVAC())),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                              aspectRatio: 2,
                              child: StateChart(
                                mapResponseInCard: mapResponse,
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

  String getTotalVAC() {

    if(mapResponse
        ==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.state}']==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.state}']["districts"]==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.state}']["districts"]['${widget.district}']
        ==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.state}']["districts"]['${widget.district}']
    ["total"]==null){
      return 0.toString();
    }
    else if(mapResponse['${formatDate()}']['${widget.state}']["districts"]['${widget.district}']
    ["total"]["vaccinated2"]==null){
      return 0.toString();
    }

    else
      return mapResponse['${formatDate()}']['${widget.state}']["districts"]['${widget.district}']
      ["total"]["vaccinated2"]
          .toString();

  }

}



class StateChart extends StatelessWidget {
  final String district;
  final String state;
  final Map mapResponseInCard;
  final String dateInString;
  final DateTime date;

  const StateChart(
      {Key key,
        this.state,
        this.mapResponseInCard,
        this.date,
        this.dateInString, this.district})
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
    }
    else if (mapResponseInCard['${previousDates(y)}']['$state'] == null) {
      return 0;
    }
    else if (mapResponseInCard['${previousDates(y)}']['$state']["districts"] == null) {
      return 0;
    }

    else if (mapResponseInCard['${previousDates(y)}']['$state']["districts"]['$district'] == null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']["districts"]['$district']
    ["total"] ==
        null) {
      return 0;
    } else if (mapResponseInCard['${previousDates(y)}']['$state']["districts"]['$district']
    ["total"]["vaccinated2"] ==
        null) {
      return 0;
    } else
      return double.parse(mapResponseInCard['${previousDates(y)}']['$state']["districts"]['$district']
      ["total"]["vaccinated2"]
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




