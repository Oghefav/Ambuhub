import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyContentPageBuilder extends StatelessWidget {
  final String? heading;
  final String? description;
  final String? placeholderText;
  final List<String>? placeholderLines;
  final String? navigationText;
  final VoidCallback? onTap;
  final Widget? icon;
  final Color? dottedBorderColor;

  const EmptyContentPageBuilder({
    super.key,
    this.heading,
    this.description,
    this.placeholderText,
    this.placeholderLines,
    this.navigationText,
    this.onTap,
    this.icon,
    this.dottedBorderColor,
  });

  Widget _buildDottedInnerContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 11.sp,
      color: AppColours.grey,
      height: 1.35,
    );
    final linkStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 11.sp,
      color: AppColours.vividTeal,
      fontWeight: FontWeight.w600,
    );

    if (placeholderLines != null && placeholderLines!.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < placeholderLines!.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                placeholderLines![i],
                textAlign: TextAlign.center,
                style: bodyStyle,
              ),
            ),
          if (navigationText != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                navigationText!,
                textAlign: TextAlign.center,
                style: linkStyle,
              ),
            ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (placeholderText != null)
          Text(
            placeholderText!,
            textAlign: TextAlign.center,
            style: bodyStyle,
          ),
        
        if (navigationText != null)
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: TextButton(
              onPressed: onTap,
              child: Text(
                navigationText!,
                style: linkStyle,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) icon!,
          if (icon != null) SizedBox(height: 15.h),
          if (heading != null) Text(heading!, style: textTheme.displayLarge),
          if (heading != null) SizedBox(height: 15.h),
          if (description != null)
            Text(description!, style: textTheme.bodyMedium),
          SizedBox(height: 25.h),
          DottedBorderContainer(
            borderColor: dottedBorderColor,
            child: SizedBox(
              height: 150.h,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildDottedInnerContent(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
