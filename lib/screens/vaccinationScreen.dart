import 'dart:convert';
import 'package:covidapp/constants.dart';
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

    String getDistrictVaccinated(DateTime date) {
      if (mapResponse['${formatDate(date)}'] == null) {
        return 0.toString();

      } else if (mapResponse['${formatDate(date)}']['$userStateCode'] == null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"] ==
          null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
              ['$userDistrict'] ==
          null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
              ['$userDistrict']["total"] ==
          null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
              ['$userDistrict']["total"]["vaccinated2"] ==
          null) {
        return 0.toString();
      } else {
        return mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
                ['$userDistrict']["total"]["vaccinated2"]
            .toString();
      }
    }


    String getDistricPopulation(DateTime date) {
      if (mapResponse['${formatDate(date)}'] == null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode'] == null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"] ==
          null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
              ['$userDistrict'] ==
          null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
              ['$userDistrict']["meta"] ==
          null) {
        return 0.toString();
      } else if (mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
              ['$userDistrict']["meta"]["population"] ==
          null) {
        return 0.toString();
      } else {
        return mapResponse['${formatDate(date)}']['$userStateCode']["districts"]
                ['$userDistrict']["meta"]["population"]
            .toString();
      }
    }

    String getStateVaccinated(DateTime date) {
      if (mapResponse['${formatDate(date)}'] ==
          null) {
        return 0.toString();
      }else if (mapResponse['${formatDate(date)}']['$userStateCode'] ==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['$userStateCode']["total"] ==
          null) {
        return 0.toString();
      }


      else if (mapResponse['${formatDate(date)}']['$userStateCode']["total"]["vaccinated2"] ==
          null) {
        return 0.toString();
      } else {
        return mapResponse['${formatDate(date)}']['$userStateCode']["total"]["vaccinated2"]
            .toString();
      }
    }

    String getStatePopulation(DateTime date) {
      if (mapResponse['${formatDate(date)}'] ==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['$userStateCode'] ==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['$userStateCode']["meta"]==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['$userStateCode']["meta"]["population"] ==
          null) {
        return 0.toString();
      }else {
        return mapResponse['${formatDate(date)}']['$userStateCode']["meta"]["population"]
            .toString();
      }
    }

    String getIndiaVaccinated(DateTime date) {
      if (mapResponse['${formatDate(date)}'] ==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['TT'] ==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['TT']["total"]==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['TT']["total"]["vaccinated2"] ==
          null) {
        return 0.toString();
      }else {
        return mapResponse['${formatDate(date)}']['TT']["total"]["vaccinated2"]
            .toString();
      }
    }

    String getIndiaPopulation(DateTime date) {
      if (mapResponse['${formatDate(date)}'] ==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['TT'] ==
          null) {
        return 0.toString();
      }
      else if (mapResponse['${formatDate(date)}']['TT']["meta"] ==
          null) {
        return 0.toString();
      }

      else if (mapResponse['${formatDate(date)}']['TT']["meta"]["population"] ==
          null) {
        return 0.toString();
      } else {
        return mapResponse['${formatDate(date)}']['TT']["meta"]["population"]
            .toString();
      }
    }

    String peoplePercent(String gds){
      if(gds=="getDistrictVaccinated"){
        if(getDistrictVaccinated(_today)=="0"){
          if(getDistrictVaccinated(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return getDistrictVaccinated(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return getDistrictVaccinated(_today);
        }
      }
      if(gds=="getDistricPopulation"){
        if(getDistricPopulation(_today)=="0"){
          if(getDistricPopulation(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return getDistricPopulation(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return getDistricPopulation(_today);
        }
      }
      if(gds=="getStateVaccinated"){
        if(getStateVaccinated(_today)=="0"){
          if(getStateVaccinated(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return getStateVaccinated(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return getStateVaccinated(_today);
        }
      }
      if(gds=="getStatePopulation"){
        if(getStatePopulation(_today)=="0"){
          if(getStatePopulation(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return getStatePopulation(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return getStatePopulation(_today);
        }
      }
      if(gds=="getIndiaVaccinated"){
        if(getIndiaVaccinated(_today)=="0"){
          if(getIndiaVaccinated(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return getIndiaVaccinated(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return getIndiaVaccinated(_today);
        }
      }
      if(gds=="getIndiaPopulation"){
        if(getIndiaPopulation(_today)=="0"){
          if(getIndiaPopulation(_today.subtract(Duration(days: 1)))=="0"){
            return 0.toString();
          }
          else{
            return getIndiaPopulation(_today.subtract(Duration(days: 1)));
          }
        }
        else{
          return getIndiaPopulation(_today);
        }
      }

    }

    int vaccinatedDistrict = int.parse(peoplePercent("getDistrictVaccinated"));
    int populationDistrict = int.parse(peoplePercent("getDistricPopulation"));
    double districtpercentage = vaccinatedDistrict==0||populationDistrict==0?0:(vaccinatedDistrict / populationDistrict);

    int vaccinatedState = int.parse(peoplePercent("getStateVaccinated"));
    int populationState = int.parse(peoplePercent("getStatePopulation"));
    double statepercentage =  vaccinatedState==0||populationState==0?0:(vaccinatedState / populationState);

    int vaccinatedIndia = int.parse(peoplePercent("getIndiaVaccinated"));
    int populationIndia = int.parse(peoplePercent("getIndiaPopulation"));
    double indiapercentage =  vaccinatedIndia==0||populationIndia==0?0:(vaccinatedIndia / populationIndia);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgGrey,
          elevation: 0,
          title: Text("Vaccination"),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  PercentageCard(
                    percentage: districtpercentage,
                    name: "$userDistrict",
                    totalVaccinated: peoplePercent("getDistrictVaccinated"),
                    page: VaccinationDistrictScreen(
                      state: "$userStateCode",
                      district: "$userDistrict",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PercentageCard(
                    percentage: statepercentage,
                    totalVaccinated: peoplePercent("getStateVaccinated"),
                    name: "$userState",
                    page: VaccinationStateScreen(
                      stateCode: "$userStateCode",
                      stateName: "$userState",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PercentageCard(
                    percentage: indiapercentage,
                    totalVaccinated: peoplePercent("getIndiaVaccinated"),
                    name: "India",
                    page: VaccinationIndiaScreen(),
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
