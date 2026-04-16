import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyContentPageBuilder extends StatelessWidget {
  final String heading;
  final String description;
  final String placeholderText;
  const EmptyContentPageBuilder({
    super.key,
    required this.heading,
    required,
    required this.description,
    required this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: Theme.of(context).textTheme.displayLarge),
          SizedBox(height: 15.h),
          Text(description, style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 25.h),
          DottedBorderContainer(
            child:  SizedBox(
              height: 150,
              width: double.maxFinite,
              child: Center(
                  child: Text(
                    placeholderText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
            ),
            
          ),
        ],
      ),
    );
  }
}
