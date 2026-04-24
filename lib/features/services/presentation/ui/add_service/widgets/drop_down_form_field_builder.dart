import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DropDownFormFieldBuilder extends StatelessWidget {
  final String hintText;
  final List<String>? items;
  final Function(String?) onChanged;
  final String title;
  final String value;
  final String placeHolder;
  final bool isEnabled;
  final String? notEnabledhintText;
  const DropDownFormFieldBuilder({
    super.key,
    required this.value,
    required this.isEnabled,
    this.notEnabledhintText,
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.title,
    required this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 5.h),
        DropdownButtonFormField<String>(
          initialValue: (items != null && items!.contains(value))? value : null,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: (!isEnabled)
                ? AppColours.veryLightVividTeal
                : Colors.transparent,
            hintText: (isEnabled) ? hintText : notEnabledhintText,
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          items: (isEnabled)
              ? [
                  DropdownMenuItem<String>(
                    value: '',
                    enabled: true,
                    child: Text(
                      placeHolder,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ...items!.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }),
                ]
              : null,
          onChanged: (isEnabled) ? onChanged : null,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
      ],
    );
  }
}
