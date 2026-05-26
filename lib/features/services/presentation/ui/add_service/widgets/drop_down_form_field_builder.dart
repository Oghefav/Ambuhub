import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_form_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownFormFieldBuilder extends StatelessWidget {
  final String hintText;
  final List<String>? items;
  final ValueChanged<String?> onChanged;
  final String title;
  final String value;
  final String placeHolder;
  final String? initialValue;
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
    this.initialValue,
  });

  String? get _resolvedValue {
    if (!isEnabled) return null;
    final selected = value.isNotEmpty ? value : (initialValue ?? '');
    if (selected.isEmpty || selected == placeHolder) return null;
    final menu = items ?? [];
    if (menu.isEmpty || !menu.contains(selected)) return null;
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = AddServiceFormStyles.hint(textTheme);
    final menuItems = items ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AddServiceFormStyles.label(textTheme)),
        SizedBox(height: 5.h),
        DropdownButtonFormField<String>(
          value: _resolvedValue,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor:
                isEnabled ? Colors.transparent : AppColours.veryLightVividTeal,
            hintText: isEnabled ? hintText : notEnabledhintText,
            hintStyle: hintStyle,
          ),
          style: hintStyle,
          iconEnabledColor: AppColours.grey,
          items: isEnabled && menuItems.isNotEmpty
              ? menuItems
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: hintStyle,
                      ),
                    ),
                  )
                  .toList()
              : null,
          onChanged: isEnabled ? onChanged : null,
        ),
      ],
    );
  }
}
