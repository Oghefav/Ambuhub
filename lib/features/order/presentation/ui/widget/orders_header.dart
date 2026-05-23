import 'package:ambuhub/config/app_colour.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersHeader extends StatelessWidget {
  final String description;

  const OrdersHeader({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge?.copyWith(
      // fontWeight: FontWeight.w700,
    );

    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Orders', style: titleStyle),
            
        Text(
          description,
          style: textTheme.bodySmall?.copyWith(color: AppColours.grey),
        ),
        
      ],
    );
  }
}
