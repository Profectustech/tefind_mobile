import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnvironmentImpactChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 1500,
            titlesData: FlTitlesData(
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  interval: 300,
                  getTitlesWidget: (value, meta) {
                    return Text('${value.toInt()} kg', style: TextStyle(fontSize: 10.sp),);
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const months = [
                      'Jun',
                      'Jul',
                      'Aug',
                      'Sep',
                      'Oct',
                      'Nov',
                      'Dec',
                      'Jan',
                      'Feb',
                      'Mar',
                      'Apr',
                    ];
                    if (value.toInt() >= 0 && value.toInt() < months.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          months[value.toInt()],
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: true,
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                gradient: LinearGradient(
                  colors: [Colors.tealAccent.withOpacity(0.3), Colors.teal.withOpacity(0.8)],
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.withOpacity(0.6),
                      Colors.teal.withOpacity(0)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                spots: [
                  FlSpot(0, 100),
                  FlSpot(1, 200),
                  FlSpot(2, 300),
                  FlSpot(3, 450),
                  FlSpot(4, 600),
                  FlSpot(5, 750),
                  FlSpot(6, 900),
                  FlSpot(7, 1050),
                  FlSpot(8, 1200),
                  FlSpot(9, 1350),
                  FlSpot(10, 1450),
                ],
                dotData: FlDotData(show: true),
                isStrokeCapRound: true,
                barWidth: 4,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
