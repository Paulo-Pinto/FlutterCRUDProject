import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/registar_model.dart';

class GraficoRegistos extends StatelessWidget {
  GraficoRegistos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
    registarM.gerarRegistos();

    return Padding(
      padding: const EdgeInsets.only(right: 22.0, bottom: 20),
      child: SizedBox(
        width: 600,
        height: 200,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                  maxContentWidth: 100,
                  tooltipBgColor: Colors.lightBlue.shade100,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      final textStyle = TextStyle(
                        color: touchedSpot.bar.colors[0],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      return LineTooltipItem(
                          '${touchedSpot.x} - ${touchedSpot.y.toStringAsFixed(2)} kg',
                          textStyle);
                    }).toList();
                  }),
              handleBuiltInTouches: true,
              getTouchLineStart: (data, index) => 0,
            ),
            lineBarsData: [
              LineChartBarData(
                colors: [
                  Colors.black,
                ],
                spots: registarM.getPesos(),
                isCurved: true,
                isStrokeCapRound: true,
                barWidth: 4,
                belowBarData: BarAreaData(
                  show: true,
                  colors: [
                    const Color(0x45A2A3FF),
                  ],
                ),
                dotData: FlDotData(show: true),
              ),
            ],
            minY: registarM.getMinPeso() - 3,
            maxY: registarM.getMaxPeso() + 3,
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Colors.blueGrey,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18),
                  margin: 16,
                  reservedSize: 40),
              rightTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Colors.blueGrey,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18),
                  margin: 16,
                  reservedSize: 6),
              topTitles: SideTitles(showTitles: false),
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              horizontalInterval: 1.5,
              verticalInterval: 5,
              checkToShowHorizontalLine: (value) {
                return value.toInt() == 0;
              },
              checkToShowVerticalLine: (value) {
                return value.toInt() == 0;
              },
            ),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}