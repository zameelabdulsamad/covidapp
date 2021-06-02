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

    String getDistrictVaccinated() {
      if (mapResponse['${formatDate(_today)}'] == null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["total"]["vaccinated"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL'] == null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["total"]["vaccinated"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["total"]["vaccinated"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"]
              ['Malappuram'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["total"]["vaccinated"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"]
              ['Malappuram']["total"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["total"]["vaccinated"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"]
              ['Malappuram']["total"]["vaccinated"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["total"]["vaccinated"]
            .toString();
      } else {
        return mapResponse['${formatDate(_today)}']['KL']["districts"]
                ['Malappuram']["total"]["vaccinated"]
            .toString();
      }
    }

    String getDistricPopulation() {
      if (mapResponse['${formatDate(_today)}'] == null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["meta"]["population"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL'] == null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["meta"]["population"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["meta"]["population"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"]
              ['Malappuram'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["meta"]["population"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"]
              ['Malappuram']["meta"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["meta"]["population"]
            .toString();
      } else if (mapResponse['${formatDate(_today)}']['KL']["districts"]
              ['Malappuram']["meta"]["population"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["districts"]['Malappuram']["meta"]["population"]
            .toString();
      } else {
        return mapResponse['${formatDate(_today)}']['KL']["districts"]
                ['Malappuram']["meta"]["population"]
            .toString();
      }
    }

    String getStateVaccinated() {
      if (mapResponse['${formatDate(_today)}'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['KL']["total"]["vaccinated"]
            .toString();
      }else if (mapResponse['${formatDate(_today)}']['KL'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['KL']["total"]["vaccinated"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['KL']["total"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['KL']["total"]["vaccinated"]
            .toString();
      }


      else if (mapResponse['${formatDate(_today)}']['KL']["total"]["vaccinated"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["total"]["vaccinated"]
            .toString();
      } else {
        return mapResponse['${formatDate(_today)}']['KL']["total"]["vaccinated"]
            .toString();
      }
    }

    String getStatePopulation() {
      if (mapResponse['${formatDate(_today)}'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['KL']["meta"]["population"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['KL'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['KL']["meta"]["population"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['KL']["meta"]==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['KL']["meta"]["population"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['KL']["meta"]["population"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['KL']["meta"]["population"]
            .toString();
      } else {
        return mapResponse['${formatDate(_today)}']['KL']["meta"]["population"]
            .toString();
      }
    }

    String getIndiaVaccinated() {
      if (mapResponse['${formatDate(_today)}'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['TT']["total"]["vaccinated"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['TT'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['TT']["total"]["vaccinated"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['TT']["total"]==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['TT']["total"]["vaccinated"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['TT']["total"]["vaccinated"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['TT']["total"]["vaccinated"]
            .toString();
      } else {
        return mapResponse['${formatDate(_today)}']['TT']["total"]["vaccinated"]
            .toString();
      }
    }

    String getIndiaPopulation() {
      if (mapResponse['${formatDate(_today)}'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['TT']["meta"]["population"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['TT'] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['TT']["meta"]["population"]
            .toString();
      }
      else if (mapResponse['${formatDate(_today)}']['TT']["meta"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
        ['TT']["meta"]["population"]
            .toString();
      }

      else if (mapResponse['${formatDate(_today)}']['TT']["meta"]["population"] ==
          null) {
        return mapResponse['${formatDate(_today.subtract(Duration(days: 1)))}']
                ['TT']["meta"]["population"]
            .toString();
      } else {
        return mapResponse['${formatDate(_today)}']['TT']["meta"]["population"]
            .toString();
      }
    }

    int vaccinatedDistrict = int.parse(getDistrictVaccinated());
    int populationDistrict = int.parse(getDistricPopulation());
    double districtpercentage = (vaccinatedDistrict / populationDistrict);

    int vaccinatedState = int.parse(getStateVaccinated());
    int populationState = int.parse(getStatePopulation());
    double statepercentage = (vaccinatedState / populationState);

    int vaccinatedIndia = int.parse(getIndiaVaccinated());
    int populationIndia = int.parse(getIndiaPopulation());
    double indiapercentage = (vaccinatedIndia / populationIndia);

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
                    name: "Malappuram",
                    totalVaccinated: getDistrictVaccinated(),
                    page: VaccinationDistrictScreen(
                      state: "KL",
                      district: "Malappuram",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PercentageCard(
                    percentage: statepercentage,
                    totalVaccinated: getStateVaccinated(),
                    name: "Kerala",
                    page: VaccinationStateScreen(
                      stateCode: "KL",
                      stateName: "Kerala",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PercentageCard(
                    percentage: indiapercentage,
                    totalVaccinated: getIndiaVaccinated(),
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
                            "Total Vaccinated",
                            style: TextStyle(fontSize: 16, color: primaryText),
                          ),
                          Text(
                            totalVaccinated,
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
