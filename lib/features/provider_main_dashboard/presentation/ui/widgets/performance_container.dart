import 'dart:math' as math;

import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_monthly_sales_entity.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_bloc.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_event.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PerformanceContainer extends StatelessWidget {
  const PerformanceContainer({super.key});

  static const Color _yearSelectorBackground = Color.fromRGBO(247, 250, 252, 1);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderDashboardBloc, ProviderDashboardState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final sales = state.yearlySales;
        final months = sales.months;

        return Card(
          color: AppColours.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(color: AppColours.veryLightGrey),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Monthly Performance',
                  style: textTheme.titleSmall,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Sales by order total (NGN)',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColours.grey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _YearSelector(
                    year: state.selectedYear,
                    onPrevious: () {
                      context.read<ProviderDashboardBloc>().add(
                            SelectProviderSalesYear(state.selectedYear - 1),
                          );
                    },
                    onNext: () {
                      context.read<ProviderDashboardBloc>().add(
                            SelectProviderSalesYear(state.selectedYear + 1),
                          );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 170.h,
                  child: _SalesBarChart(months: months),
                ),
                SizedBox(height: 10.h),
                Text(
                  '${sales.year} total: ${formatCurrency(sales.yearTotalNgn)}',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColours.darkGrey,
                  ),
                ),
                if (!sales.hasQualifyingOrders) ...[
                  SizedBox(height: 10.h),
                  Text(
                    'No qualifying orders in this year. Use Prev/Next if your sales are dated in another year (UTC). Orders must include your listing (seller id or active service row).',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColours.grey,
                      fontSize: 11.sp,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _YearSelector extends StatelessWidget {
  final int year;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _YearSelector({
    required this.year,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controlStyle = textTheme.bodyMedium?.copyWith(
      color: AppColours.vividTeal,
      fontWeight: FontWeight.w600,
    );
    final yearStyle = textTheme.titleSmall?.copyWith(
      color: AppColours.darkGrey,
      fontWeight: FontWeight.w700,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: PerformanceContainer._yearSelectorBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColours.veryLightGrey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.w,
        children: [
          _YearSelectorButton(label: 'Prev', onTap: onPrevious, style: controlStyle),
          Text('$year', style: yearStyle),
          _YearSelectorButton(label: 'Next', onTap: onNext, style: controlStyle),
        ],
      ),
    );
  }
}

class _YearSelectorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final TextStyle? style;

  const _YearSelectorButton({
    required this.label,
    required this.onTap,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        child: Text(label, style: style),
      ),
    );
  }
}

class _SalesBarChart extends StatelessWidget {
  final List<ProviderMonthlySalesPointEntity> months;

  const _SalesBarChart({required this.months});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final borderRadius = BorderRadius.vertical(top: Radius.circular(4.r));
    final monthCount = months.isEmpty ? 12 : months.length;

    final maxTotal = months.fold<double>(
      0,
      (max, month) => month.totalNgn > max ? month.totalNgn : max,
    );
    final chartMaxY = maxTotal > 0 ? maxTotal * 1.08 : 1.0;
    final minBarY = chartMaxY * 0.06;

    return LayoutBuilder(
      builder: (context, constraints) {
        final chartWidth = constraints.maxWidth;
        final slotWidth = chartWidth / monthCount;
        final barWidth =
            math.min(slotWidth * 0.72, 18.0).clamp(6.0, slotWidth - 2);

        return Container(
          width: chartWidth,
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
          padding: EdgeInsets.only(top: 8.h),
          child: BarChart(
            BarChartData(
              minY: 0,
              maxY: chartMaxY,
              alignment: BarChartAlignment.spaceBetween,
              groupsSpace: 2,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: const BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24.h,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= months.length) {
                        return const SizedBox.shrink();
                      }
                      return SizedBox(
                        width: slotWidth,
                        child: Text(
                          months[index].label,
                          textAlign: TextAlign.center,
                          style: textTheme.labelSmall?.copyWith(
                            color: AppColours.grey,
                            fontSize: 9.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(months.length, (index) {
                final total = months[index].totalNgn;
                final barHeight = total <= 0 ? minBarY : total;

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      fromY: 0,
                      toY: barHeight,
                      width: barWidth,
                      borderRadius: borderRadius,
                      color: AppColours.penBlue,
                      gradient: const LinearGradient(
                        colors: [AppColours.penBlue, AppColours.veryLightBlue],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
