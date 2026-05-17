import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDropContainer extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String?) onChanged;
  const SearchDropContainer({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500, color: AppColours.white),
        ),
        SizedBox(height: 5.h),
        DropdownButtonFormField<String>(
          initialValue: items.first,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          dropdownColor: AppColours.white,
          style: textTheme.bodyMedium!.copyWith(color: AppColours.white),
          decoration: const InputDecoration(),
        ),
      ],
    );
  }
}
