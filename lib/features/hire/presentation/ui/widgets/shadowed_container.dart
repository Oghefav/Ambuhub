import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShadowedContainer extends StatelessWidget {
  final List<Color>? topGradientColors;
  final List<Color>? bodyGradientColors;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<double>? bodyStops;
  final List<double>? topStops;
  final Widget body;
  final Color shadowColor;
  final Color borderColor;
  const ShadowedContainer({
    super.key,
    this.topGradientColors,
    this.bodyGradientColors,
    this.begin,
    this.end,
    required this.bodyStops,
    required this.topStops,
    required this.body,
    required this.shadowColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final topColors = topGradientColors ?? [AppColours.white, AppColours.white];
    final bodyColors =
        bodyGradientColors ?? [AppColours.white, AppColours.white];

    return Container(
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: borderColor),
        gradient: LinearGradient(
          colors: bodyColors,
          begin: begin ?? Alignment.topCenter,
          end: end ?? Alignment.bottomCenter,
          stops: bodyStops,
        ),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 10.r)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.r),
                    ),
                    gradient: LinearGradient(
                      colors: topColors,
                      begin: begin ?? Alignment.centerLeft,
                      end: end ?? Alignment.centerRight,
                      stops: topStops,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15.w),
            child: body,
          ),
        ],
      ),
    );
  }
}
