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
      FlSpot(0, 3500),
      FlSpot(1, 3000),
      FlSpot(2, 2200),
      FlSpot(3, 1750),
      FlSpot(4, 8000),
      FlSpot(5, 8500),
      FlSpot(6, 3200),
      FlSpot(7, 2700),
      FlSpot(8, 9000),
    ];
  }
}
