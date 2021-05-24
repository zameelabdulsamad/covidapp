import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';

class DistrictScreen extends StatefulWidget {
  const DistrictScreen({Key key}) : super(key: key);

  @override
  _DistrictScreenState createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text("Malappuram"),
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

                    firstDay: DateTime.utc(2020, 01, 01),
                    lastDay: DateTime.now(),

                    calendarFormat: CalendarFormat.week,
                    focusedDay: DateTime.now(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
