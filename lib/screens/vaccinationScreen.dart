import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/screens/homeScreen.dart';
import 'package:covidapp/screens/registerVaccinationScreen.dart';
import 'package:covidapp/screens/vaccinationDistrictScreen.dart';
import 'package:covidapp/screens/vaccinationIndiaScreen.dart';
import 'package:covidapp/screens/vaccinationStateScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({Key key}) : super(key: key);

  @override
  _VaccinationScreenState createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;


    DateTime _today = DateTime.now();
    String formatDate(DateTime x) {
      var outFormatter = new DateFormat('yyyy-MM-dd');
      return outFormatter.format(x);
    }


    Future<String> getDistrictVaccinated( DateTime date) async{
      String _returnValue="0";
      await FirebaseFirestore.instance
          .doc('${formatdate(date)}/$userStateCode/districts/$userDistrict')
          .get().then((documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {
          _returnValue=(data == null ||data['total'] == null||data['total']['vaccinated2'] == null)?0.toString():_returnValue=data['total']['vaccinated2'].toString();


        }
        else{

          _returnValue=0.toString();
        }
      });
      return _returnValue;
    }



    Future<String> getDistricPopulation( DateTime date) async{
      String _returnValue="0";
      await FirebaseFirestore.instance
          .doc('${formatdate(date)}/$userStateCode/districts/$userDistrict')
          .get().then((documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {
          _returnValue=(data == null ||data['meta'] == null||data['meta']['population'] == null)?0.toString():_returnValue=data['meta']['population'].toString();


        }
        else{

          _returnValue=0.toString();
        }
      });
      return _returnValue;
    }


    Future<String> getStateVaccinated( DateTime date) async{
      String _returnValue="0";
      await FirebaseFirestore.instance
          .doc('${formatdate(date)}/$userStateCode')
          .get().then((documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {
          _returnValue=(data == null ||data['total'] == null||data['total']['vaccinated2'] == null)?0.toString():_returnValue=data['total']['vaccinated2'].toString();


        }
        else{

          _returnValue=0.toString();
        }
      });
      return _returnValue;
    }
    Future<String> getStatePopulation( DateTime date) async{
      String _returnValue="0";
      await FirebaseFirestore.instance
          .doc('${formatdate(date)}/$userStateCode')
          .get().then((documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {
          _returnValue=(data == null ||data['meta'] == null||data['meta']['population'] == null)?0.toString():_returnValue=data['meta']['population'].toString();


        }
        else{

          _returnValue=0.toString();
        }
      });
      return _returnValue;
    }




    Future<String> getIndiaVaccinated( DateTime date) async{
      String _returnValue="0";
      await FirebaseFirestore.instance
          .doc('${formatdate(date)}/TT')
          .get().then((documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {
          _returnValue=(data == null ||data['total'] == null||data['total']['vaccinated2'] == null)?0.toString():_returnValue=data['total']['vaccinated2'].toString();


        }
        else{

          _returnValue=0.toString();
        }
      });
      return _returnValue;
    }
    Future<String> getIndiaPopulation( DateTime date) async{
      String _returnValue="0";
      await FirebaseFirestore.instance
          .doc('${formatdate(date)}/TT')
          .get().then((documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {
          _returnValue=(data == null ||data['meta'] == null||data['meta']['population'] == null)?0.toString():_returnValue=data['meta']['population'].toString();


        }
        else{

          _returnValue=0.toString();
        }
      });
      return _returnValue;
    }

    Future<String> peoplePercent(String gds)async{
      if(gds=="getDistrictVaccinated"){
        if(await getDistrictVaccinated(_today)=="0"){
          if(await getDistrictVaccinated(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return await getDistrictVaccinated(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return await getDistrictVaccinated(_today);
        }
      }
      if(gds=="getDistricPopulation"){
        if(await getDistricPopulation(_today)=="0"){
          if(await getDistricPopulation(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return await getDistricPopulation(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return await getDistricPopulation(_today);
        }
      }
      if(gds=="getStateVaccinated"){
        if(await getStateVaccinated(_today)=="0"){
          if(await getStateVaccinated(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return await getStateVaccinated(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return await getStateVaccinated(_today);
        }
      }
      if(gds=="getStatePopulation"){
        if(await getStatePopulation(_today)=="0"){
          if(await getStatePopulation(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return await getStatePopulation(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return await getStatePopulation(_today);
        }
      }
      if(gds=="getIndiaVaccinated"){
        if(await getIndiaVaccinated(_today)=="0"){
          if(await getIndiaVaccinated(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return await getIndiaVaccinated(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return await getIndiaVaccinated(_today);
        }
      }
      if( gds=="getIndiaPopulation"){
        if(await getIndiaPopulation(_today)=="0"){
          if(await getIndiaPopulation(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return await getIndiaPopulation(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return await getIndiaPopulation(_today);
        }
      }

    }



    Future<double> getDistrictPercent() async{
      double percent;
      String vaccinated = await peoplePercent("getDistrictVaccinated");
      int vaccinatedinInt = int.parse(vaccinated);
      String population = await peoplePercent("getDistricPopulation");
      int populationinInt = int.parse(population);
      percent = vaccinatedinInt == 0 || populationinInt == 0 ? 0 : (vaccinatedinInt / populationinInt);
      return percent;


    }



    Future<double> getStatePercent() async{
      double percent;
      String vaccinated = await peoplePercent("getStateVaccinated");
      int vaccinatedinInt = int.parse(vaccinated);
      String population = await peoplePercent("getStatePopulation");
      int populationinInt = int.parse(population);
      percent = vaccinatedinInt == 0 || populationinInt == 0 ? 0 : (vaccinatedinInt / populationinInt);
      return percent;


    }





    Future<double> getIndiaPercent() async{
      double percent;
      String vaccinated = await peoplePercent("getIndiaVaccinated");
      int vaccinatedinInt = int.parse(vaccinated);
      String population = await peoplePercent("getIndiaPopulation");
      int populationinInt = int.parse(population);
      percent = vaccinatedinInt == 0 || populationinInt == 0 ? 0 : (vaccinatedinInt / populationinInt);
      return percent;


    }
    Future<Map> distictData() async{
      Map abc={"percent":await getDistrictPercent(),
      "vaccinated":await peoplePercent("getDistrictVaccinated")};
      return abc;
    }
    Future<Map> stateData() async{
      Map abc={"percent":await getStatePercent(),
        "vaccinated":await peoplePercent("getStateVaccinated")};
      return abc;
    }
    Future<Map> indiaData() async{
      Map abc={"percent":await getIndiaPercent(),
        "vaccinated":await peoplePercent("getIndiaVaccinated")};
      return abc;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgGrey,
          elevation: 0,
          title: Text("Vaccination"),
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),

            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  FutureBuilder(
                      future: distictData(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return PercentageCard(
                            percentage: snapshot.data["percent"],
                            name: "$userDistrict",
                            totalVaccinated: snapshot.data["vaccinated"],
                            page: VaccinationDistrictScreen(
                              state: "$userStateCode",
                              district: "$userDistrict",
                            ),
                          )

                          ;
                        }
                        if(snapshot.hasError){
                          return Shimmer.fromColors(
                            baseColor: shimmerbasecolor,
                            highlightColor: shimmerhighlightcolor,
                            child: Container(
                              height: maxHeight * 0.24,
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
                          child: Container(
                            height: maxHeight * 0.24,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: stateData(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return PercentageCard(
                            percentage: snapshot.data["percent"],
                            totalVaccinated: snapshot.data["vaccinated"],
                            name: "$userState",
                            page: VaccinationStateScreen(
                              stateCode: "$userStateCode",
                              stateName: "$userState",
                            ),
                          )


                          ;
                        }
                        if(snapshot.hasError){
                          return Shimmer.fromColors(
                            baseColor: shimmerbasecolor,
                            highlightColor: shimmerhighlightcolor,
                            child: Container(
                              height: maxHeight * 0.24,
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
                          child: Container(
                            height: maxHeight * 0.24,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: indiaData(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return PercentageCard(
                            percentage: snapshot.data["percent"],
                            totalVaccinated: snapshot.data["vaccinated"],

                            name: "India",
                            page: VaccinationIndiaScreen(),
                          )



                        ;
                        }
                        if(snapshot.hasError){
                          return Shimmer.fromColors(
                            baseColor: shimmerbasecolor,
                            highlightColor: shimmerhighlightcolor,
                            child: Container(
                              height: maxHeight * 0.24,
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
                          child: Container(
                            height: maxHeight * 0.24,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterVaccinationScreen()));
                    },
                    child: Container(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: new SvgPicture.asset(
                                  'assets/icons/edit.svg',
                                  height: 40,
                                  width: 40,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "REGISTER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "for Vaccination",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: maxHeight * 0.22,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryRed,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 16),
                                    child: Icon(
                                      Icons.download_rounded,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                  ),
                                  Text(
                                    "DOWNLOAD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Certificate",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryRed,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 16),
                                    child: Icon(
                                      Icons.article,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                                  ),
                                  Text(
                                    "NEWS",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}

class PercentageCard extends StatelessWidget {
  const PercentageCard({
    Key key,
    this.percentage,
    this.totalVaccinated,
    this.name,
    this.page,
  }) : super(key: key);

  final String totalVaccinated;
  final double percentage;
  final String name;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
                    top: 16.0, left: 10, bottom: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 16, left: 16),
                      child: new CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 30.0,
                        percent: percentage,
                        center: new Text(
                          "${(percentage * 100).round()}%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryText,
                              fontSize: 20),
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
                            "Vaccinated both",
                            style: TextStyle(fontSize: 16, color: primaryText),
                          ),
                          Text(
                            NumberFormat.decimalPattern().format(int.parse(totalVaccinated))
                            ,
                            style: TextStyle(
                                fontSize: 20,
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
    );
  }
}
