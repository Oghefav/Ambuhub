import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueShoppingContainer extends StatelessWidget {
  const ContinueShoppingContainer({super.key});

  static const LinearGradient _gradient = LinearGradient(
    colors: [AppColours.actionBlue, AppColours.teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _popToMarketplace(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          gradient: _gradient,
          borderRadius: BorderRadius.circular(15.r),
        ),
        alignment: Alignment.center,
        child: Text(
          'Continue shopping',
          textAlign: TextAlign.center,
          style: textTheme.titleSmall?.copyWith(
            color: AppColours.white,
          ),
        ),
      ),
    );
  }
}

void _popToMarketplace(BuildContext context) {
  Navigator.popUntil(
    context,
    (route) =>
        route.settings.name == AppRoutes.markerScreen || route.isFirst,
  );
}
