import 'package:ambuhub/config/app_colour.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PerformanceContainer extends StatelessWidget {
  const PerformanceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = 20.w;
    final borderRadius = BorderRadius.circular(4.r);
    final linearGradient = LinearGradient(
      colors: [AppColours.penBlue, AppColours.veryLightBlue],
      stops: [0.0, 1.0],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

    return Card(
      color: AppColours.white,
      child: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Performance',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Jan - Aug',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                gradient: LinearGradient(
                  colors: [
                    AppColours.veryLightBlue.withAlpha(20),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: 150.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 30.h,
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 10,
                          width: width, // How wide the bar is
                          borderRadius: borderRadius,
                          gradient: linearGradient,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 15,
                          width: width,
                          gradient: linearGradient,
                          borderRadius: borderRadius,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 12,
                          width: width,
                          gradient: linearGradient,
                          borderRadius: borderRadius,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 18,
                          width: width,
                          gradient: linearGradient,
                          borderRadius: borderRadius,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          toY: 10,
                          width: width,
                          gradient: linearGradient,
                          borderRadius: borderRadius,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(
                          toY: 12,
                          width: width,
                          gradient: linearGradient,
                          borderRadius: borderRadius,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(
                          toY: 20,
                          width: width,
                          gradient: linearGradient,
                          borderRadius: borderRadius,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 7,
                      barRods: [
                        BarChartRodData(
                          toY: 17,
                          width: width,
                          gradient: linearGradient,
                          borderRadius: borderRadius,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
