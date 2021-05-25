import 'dart:ui';

import 'package:covidapp/constants.dart';
import 'package:covidapp/screens/districtScreen.dart';
import 'package:covidapp/screens/newsScreen.dart';
import 'package:covidapp/widgets/linechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
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
                runSpacing: 10,
                spacing: 10,
                children: <Widget>[
                  HomeInfoCard(
                    title: "Total Confirmed",
                    iconColor: coronaYellow,
                    effectedNum: 1062,
                  ),
                  HomeInfoCard(
                    title: "Total Deaths",
                    iconColor: coronaRed,
                    effectedNum: 650,
                  ),
                  HomeInfoCard(
                    title: "Total Recovered",
                    iconColor: coronaGreen,
                    effectedNum: 15,
                  ),
                  HomeInfoCard(
                    title: "New Cases",
                    iconColor: coronaBlue,
                    effectedNum: 47,
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
                        homeButtonPage: DistrictScreen(),
                      ),
                      homeButton(
                        title: "News",
                        buttonIcon: Icons.article,
                        homeButtonPage: NewsScreen(),
                      ),
                      homeButton(
                        title: "Vaccination",
                        buttonIcon: Icons.medical_services_rounded,
                        homeButtonPage: NewsScreen(),

                      ),
                      homeButton(
                        title: "Helpline",
                        buttonIcon: Icons.headset,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "News",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      )),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: bgGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),SizedBox(height: 20),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(

                          decoration: BoxDecoration(
                            color: primaryRed,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: new SvgPicture.asset(
                                    'assets/icons/edit.svg',
                                    height: 30,
                                    width: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right:10,top: 10),
                                  child: Column(children: [
                                    Text("REGISTER",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                    Text("your Vacination slot",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),)
                                  ],),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(

                          decoration: BoxDecoration(
                            color: primaryRed,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.insert_chart_outlined,color: Colors.white,size: 30,),
                                Text("Vaccination",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
                                Text("Status",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),)
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
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: bgGrey,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
          color: iconGrey,
        )
      ],
    );
  }
}

class homeButton extends StatelessWidget {
  final String title;
  final IconData buttonIcon;
  final Widget homeButtonPage;

  const homeButton({
    Key key,
    this.title,
    this.buttonIcon, this.homeButtonPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homeButtonPage),
            );
          },
          child: Container(

            height: 60,
            width: 60,
            decoration: BoxDecoration(color: primaryRed, shape: BoxShape.circle),
            child: Icon(
              buttonIcon,
              size: 36,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: primaryText),
          ),
        )
      ],
    );
  }
}

class HomeInfoCard extends StatelessWidget {
  final String title;
  final int effectedNum;
  final Color iconColor;

  const HomeInfoCard({
    Key key,
    this.title,
    this.effectedNum,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
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
                        fontSize:
                            AdaptiveTextSize().getadaptiveTextSize(context, 10),
                        fontWeight: FontWeight.bold),
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
                                text: "$effectedNum\n",
                                style: TextStyle(
                                    fontSize: AdaptiveTextSize()
                                        .getadaptiveTextSize(context, 22),
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "People",
                                style: TextStyle(
                                  fontSize: AdaptiveTextSize()
                                      .getadaptiveTextSize(context, 10),
                                  height: 1,
                                ))
                          ]),
                    ),
                  ),
                  Expanded(
                    child: LineReportChart(),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
