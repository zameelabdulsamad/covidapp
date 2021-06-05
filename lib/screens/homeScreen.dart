import 'dart:ui';
import 'package:covidapp/constants.dart';
import 'package:covidapp/screens/boardingScreen.dart';
import 'package:covidapp/screens/changeUserLocation.dart';
import 'package:covidapp/screens/districtScreen.dart';
import 'package:covidapp/screens/indiaScreen.dart';
import 'package:covidapp/screens/settingsPage.dart';
import 'package:covidapp/screens/stateScreen.dart';
import 'package:covidapp/screens/statusScreen.dart';
import 'package:covidapp/screens/vaccinationDistrictScreen.dart';
import 'package:covidapp/screens/vaccinationScreen.dart';
import 'package:covidapp/userPrefs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List WMapResponse;
List WListResponse;
Map mapResponse;
bool download = false;
String userDistrict;
String userState;
String userDistrictCode;
String userStateCode;
DateTime _today = DateTime.now();

String formatdate(DateTime date) {
  var outFormatter = new DateFormat('yyyy-MM-dd');
  return outFormatter.format(date);
}

class _HomeScreenState extends State<HomeScreen> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  Future fetchData() async {
    http.Response response2;
    var url2 = Uri.parse("https://coronavirus-19-api.herokuapp.com/countries");
    response2 = await http.get(url2);
    http.Response response3;
    var url3 =
        Uri.parse("https://api.covid19india.org/v4/min/data-all.min.json");
    response3 = await http.get(url3);
    print(response2.statusCode);

    print(response3.statusCode);
    if (response2.statusCode == 200 && response3.statusCode == 200) {
      setState(() {
        WMapResponse = json.decode(response2.body);
        mapResponse = json.decode(response3.body);
        download = true;
      });
    }
  }

  @override
  void initState() {
    fetchData();
    userDistrict = UserPreferences().districtName;
    userState = UserPreferences().stateName;
    userDistrictCode = UserPreferences().districtCode;
    userStateCode = UserPreferences().stateCode;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    int tested;
    int confirmed;
    double tppercent;
    void takeDatas() {
      tested = int.parse(testpositivityData("tested"));
      confirmed = int.parse(testpositivityData("confirmed"));
      tppercent = tested == 0 || confirmed == 0 ? 0 : (confirmed / tested);
    }

    if (download == true) {
      takeDatas();
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgGrey,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 10),
                    child: !download
                        ? Container(
                      width: maxWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                      baseColor: shimmerbasecolor,
                      highlightColor: shimmerhighlightcolor,
                      child: Container(
                              height: 25,
                              width: maxWidth*0.4,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                      ),
                    ),
                            ],
                          ),
                        )
                        :GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeUserLocation()));
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: iconGrey,
                              size: 28,
                            ),
                            Text(
                              userDistrict,
                              style: TextStyle(
                                  color: primaryText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: <Widget>[
                      HomeInfoCard(
                        title: "Confirmed",
                        iconColor: coronaYellow,
                        today: _today,
                        item: "confirmed",
                        homeInfoCardPage: DistrictScreen(
                          district: userDistrict,
                          state: userStateCode,
                        ),
                      ),
                      HomeInfoCard(
                        title: "Deceased",
                        iconColor: coronaRed,
                        today: _today,
                        item: "deceased",
                        homeInfoCardPage: DistrictScreen(
                          district: userDistrict,
                          state: userStateCode,
                        ),
                      ),
                      HomeInfoCard(
                        title: "Recovered",
                        iconColor: coronaGreen,
                        today: _today,
                        item: "recovered",
                        homeInfoCardPage: DistrictScreen(
                          district: userDistrict,
                          state: userStateCode,
                        ),
                      ),
                      HomeInfoCard(
                        title: "Vaccinated",
                        iconColor: coronaBlue,
                        today: _today,
                        item: "vaccinated2",
                        homeInfoCardPage: VaccinationDistrictScreen(
                          district: userDistrict,
                          state: userStateCode,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      homeButton(
                          title: "Status",
                          buttonIcon: Icons.bar_chart,
                          homeButtonPage: StatusScreen()),
                      homeButton(
                        title: "News",
                        buttonIcon: Icons.article,
                      ),
                      homeButton(
                        title: "Vaccination",
                        buttonIcon: Icons.medical_services_rounded,
                        homeButtonPage: VaccinationScreen(),
                      ),
                      homeButton(
                        title: "Helpline",
                        buttonIcon: Icons.headset,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  !download
                      ? Shimmer.fromColors(
                          baseColor: shimmerbasecolor,
                          highlightColor: shimmerhighlightcolor,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: bgGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                  SizedBox(height: 10),
                  !download
                      ? Shimmer.fromColors(
                          baseColor: shimmerbasecolor,
                          highlightColor: shimmerhighlightcolor,
                          child: Container(
                            height: maxHeight * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StateScreen(
                                        stateName: userState,
                                        stateCode: userStateCode,
                                      )),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: bgGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0,
                                        left: 10,
                                        bottom: 8,
                                        right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Test Positivity",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryText),
                                            ),
                                            Text(
                                              userState,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryText),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 16, left: 16),
                                          child: new CircularPercentIndicator(
                                            radius: 110.0,
                                            lineWidth: 30.0,
                                            percent: tppercent,
                                            center: new Text(
                                              "${(tppercent * 100).toStringAsFixed(1)}%",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryText,
                                                  fontSize: 12),
                                            ),
                                            progressColor: primaryRed,
                                            backgroundColor: iconGrey,
                                            circularStrokeCap:
                                                CircularStrokeCap.butt,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Total Tested",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: primaryText),
                                              ),
                                              Text(
                                                NumberFormat.decimalPattern()
                                                    .format(int.parse(
                                                        testpositivityData(
                                                            "tested"))),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: primaryText,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                  SizedBox(
                    height: 10,
                  ),
                  !download
                      ? Shimmer.fromColors(
                    baseColor: shimmerbasecolor,
                    highlightColor: shimmerhighlightcolor,
                    child: Container(
                      height: maxHeight * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                      :GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndiaScreen()));
                    },
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
                                top: 16.0, left: 10, bottom: 20, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "India",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: primaryText),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 26, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RowItem(
                                  mapResponseInRow: mapResponse,
                                  txColor: cardYellow,
                                  txHeading: "CONFIRMED",
                                  item: "confirmed",
                                ),
                                RowItem(
                                  mapResponseInRow: mapResponse,
                                  txColor: cardGreen,
                                  txHeading: "RECOVERED",
                                  item: "recovered",
                                ),
                                RowItem(
                                  mapResponseInRow: mapResponse,
                                  txColor: primaryRed,
                                  txHeading: "DECEASED",
                                  item: "deceased",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Covid Point"),
      backgroundColor: bgGrey,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
          color: iconGrey,
        )
      ],
    );
  }

  String tpValues(String item, DateTime date) {
    if (mapResponse == null) {
      return 0.toString();
    } else if (mapResponse['${formatdate(date)}'] == null) {
      return 0.toString();
    } else if (mapResponse['${formatdate(date)}']['$userStateCode'] == null) {
      return 0.toString();
    } else if (mapResponse['${formatdate(date)}']['$userStateCode']["delta"] ==
        null) {
      return 0.toString();
    } else if (mapResponse['${formatdate(date)}']['$userStateCode']["delta"]
            ["$item"] ==
        null) {
      return 0.toString();
    } else
      return mapResponse['${formatdate(date)}']['$userStateCode']["delta"]
              ["$item"]
          .toString();
  }

  String testpositivityData(String item) {
    if (tpValues(item, _today) == "0") {
      if (tpValues(item, _today.subtract(Duration(days: 1))) == "0") {
        return 0.toString();
      } else {
        return tpValues(item, _today.subtract(Duration(days: 1)));
      }
    } else {
      return tpValues(item, _today);
    }
  }
}

class homeButton extends StatelessWidget {
  final String title;
  final IconData buttonIcon;
  final Widget homeButtonPage;

  const homeButton({
    Key key,
    this.title,
    this.buttonIcon,
    this.homeButtonPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        !download
            ? Shimmer.fromColors(
                baseColor: shimmerbasecolor,
                highlightColor: shimmerhighlightcolor,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homeButtonPage),
                  );
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration:
                      BoxDecoration(color: primaryRed, shape: BoxShape.circle),
                  child: Icon(
                    buttonIcon,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: !download
              ? Shimmer.fromColors(
                  baseColor: shimmerbasecolor,
                  highlightColor: shimmerhighlightcolor,
                  child: Container(
                    width: 60,
                    height: 10,
                    color: Colors.grey,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: primaryText),
                ),
        )
      ],
    );
  }
}

class HomeInfoCard extends StatelessWidget {
  final String title;
  final Color iconColor;
  final String item;
  final DateTime today;
  final Widget homeInfoCardPage;

  const HomeInfoCard({
    Key key,
    this.title,
    this.iconColor,
    this.item,
    this.today,
    this.homeInfoCardPage,
  }) : super(key: key);

  String formatDate(DateTime date) {
    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(builder: (context, constraints) {
      return !download
          ? Shimmer.fromColors(
              baseColor: shimmerbasecolor,
              highlightColor: shimmerhighlightcolor,
              child: Container(
                width: constraints.maxWidth / 2 - 10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(height: maxHeight * 0.13),
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => homeInfoCardPage),
                );
              },
              child: Container(
                width: constraints.maxWidth / 2 - 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: iconColor.withOpacity(0.12),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.coronavirus_rounded,
                              size: 18,
                              color: iconColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10.0, left: 10, right: 10),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(color: primaryText),
                                  children: [
                                    TextSpan(
                                        text:
                                            "${NumberFormat.decimalPattern().format(int.parse(numberOfPeople()))}\n",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: "People",
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1,
                                        ))
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: AspectRatio(
                                aspectRatio: 3,
                                child: LineChart(LineChartData(
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(show: false),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                          barWidth: 3,
                                          colors: [primaryRed],
                                          spots: getGraphData(),
                                          isCurved: true,
                                          dotData: FlDotData(show: false),
                                          belowBarData:
                                              BarAreaData(show: false))
                                    ]))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
    });
  }

  String previousDates(int x) {
    DateTime pvDate = _today.subtract(Duration(days: x));

    var outFormatter = new DateFormat('yyyy-MM-dd');
    return outFormatter.format(pvDate);
  }

  double getData(int y) {
    if (mapResponse == null)
      return 0;
    else if (mapResponse['${previousDates(y)}'] == null) {
      return 0;
    } else if (mapResponse['${previousDates(y)}']['$userStateCode'] == null) {
      return 0;
    } else if (mapResponse['${previousDates(y)}']['$userStateCode']
            ['districts'] ==
        null) {
      return 0;
    } else if (mapResponse['${previousDates(y)}']['$userStateCode']['districts']
            ['$userDistrict'] ==
        null) {
      return 0;
    } else if (mapResponse['${previousDates(y)}']['$userStateCode']['districts']
            ['$userDistrict']["delta"] ==
        null) {
      return 0;
    } else if (mapResponse['${previousDates(y)}']['$userStateCode']['districts']
            ['$userDistrict']["delta"]["$item"] ==
        null) {
      return 0;
    } else
      return double.parse(mapResponse['${previousDates(y)}']['$userStateCode']
              ['districts']['$userDistrict']["delta"]["$item"]
          .toString());
  }

  String numberOfPeople() {
    if (itemNumber(_today) == "0") {
      if (itemNumber(_today.subtract(Duration(days: 1))) == "0") {
        return "0";
      } else {
        return itemNumber(_today.subtract(Duration(days: 1)));
      }
    } else {
      itemNumber(_today);
    }
  }

  String itemNumber(DateTime date) {
    if (mapResponse == null) {
      return 0.toString();
    } else if (mapResponse['${formatDate(date)}'] == null) {
      return 0.toString();
    } else if (mapResponse['${formatDate(date)}']['$userStateCode'] == null) {
      return 0.toString();
    } else if (mapResponse['${formatDate(date)}']['$userStateCode']
            ['districts'] ==
        null) {
      return 0.toString();
    } else if (mapResponse['${formatDate(date)}']['$userStateCode']['districts']
            ['$userDistrict'] ==
        null) {
      return 0.toString();
    } else if (mapResponse['${formatDate(date)}']['$userStateCode']['districts']
            ['$userDistrict']["delta"] ==
        null) {
      return 0.toString();
    } else if (mapResponse['${formatDate(date)}']['$userStateCode']['districts']
            ['$userDistrict']["delta"]["$item"] ==
        null) {
      return 0.toString();
    } else
      return mapResponse['${formatDate(date)}']['$userStateCode']['districts']
              ['$userDistrict']["delta"]["$item"]
          .toString();
  }

  List<FlSpot> getGraphData() {
    return [
      FlSpot(0, getData(6)),
      FlSpot(1, getData(5)),
      FlSpot(2, getData(4)),
      FlSpot(3, getData(3)),
      FlSpot(4, getData(2)),
      FlSpot(5, getData(1)),
      FlSpot(6, getData(0)),
    ];
  }
}

class RowItem extends StatelessWidget {
  final Color txColor;
  final String item;
  final String txHeading;
  final Map mapResponseInRow;
  final DateTime currentDate;

  const RowItem(
      {Key key,
      this.txColor,
      this.item,
      this.txHeading,
      this.mapResponseInRow,
      this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            NumberFormat.decimalPattern()
                .format(int.parse(finalNumber("delta"))),
            style: TextStyle(
              color: primaryText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        Text(txHeading,
            style: TextStyle(
              color: txColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        Text(
            NumberFormat.decimalPattern()
                .format(int.parse(finalNumber("total"))),
            style: TextStyle(
              color: primaryText,
              fontSize: 14,
            )),
      ],
    );
  }

  String finalNumber(String deltaortotal) {
    DateTime _today = DateTime.now();
    String formatDate(DateTime day) {
      var outFormatter = new DateFormat('yyyy-MM-dd');
      return outFormatter.format(day);
    }

    if (itemNumber(deltaortotal, formatDate(_today)) == "0") {
      if (itemNumber(
              deltaortotal, formatDate(_today.subtract(Duration(days: 1)))) ==
          "0") {
        return 0.toString();
      } else {
        return itemNumber(
            deltaortotal, formatDate(_today.subtract(Duration(days: 1))));
      }
    } else {
      return itemNumber(deltaortotal, formatDate(_today));
    }
  }

  String itemNumber(String deltaortotal, String date) {
    if (mapResponseInRow == null)
      return 0.toString();
    else if (mapResponseInRow['$date'] == null) {
      return 0.toString();
    } else if (mapResponseInRow['$date']['TT'] == null) {
      return 0.toString();
    } else if (mapResponseInRow['$date']['TT']["$deltaortotal"] == null) {
      return 0.toString();
    } else if (mapResponseInRow['$date']['TT']["$deltaortotal"]["$item"] ==
        null) {
      return 0.toString();
    } else
      return mapResponseInRow['$date']['TT']["$deltaortotal"]["$item"]
          .toString();
  }
}
