import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
class LineReportChart extends StatelessWidget {
  const LineReportChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 3,
        child: LineChart(LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                  barWidth: 3,
                  colors: [primaryRed],
                  spots: getSpots(),
                  isCurved: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false))
            ])));
  }

  List<FlSpot> getSpots() {
    return [
      FlSpot(0, .5),
      FlSpot(1, 1.5),
      FlSpot(2, .3),
      FlSpot(3, 2.5),
      FlSpot(4, 3.5),
      FlSpot(5, 1.5),
      FlSpot(6, 3.5),
      FlSpot(7, 1.5),
      FlSpot(8, .5),
    ];
  }
}
