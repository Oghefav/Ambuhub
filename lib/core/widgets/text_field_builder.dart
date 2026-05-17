import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldBuilder extends HookWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isObsure;
  final int? maxLines;
  final TextInputType inputType;
  final IconData? prefixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;

  const TextFieldBuilder({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isObsure = false,
    required this.inputType,
    this.maxLines,
    this.prefixIcon,
    this.onChanged,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    final isTextObsure = useState<bool>(isObsure);

    useListenable(controller);

    return Padding(
      padding:EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp)),
          SizedBox(height: 5.h),
          TextFormField(
            controller: controller,
            obscureText: isTextObsure.value,
            validator: validator ?? (value) => null,
            keyboardType: inputType,
            onChanged: onChanged,
            autofillHints: autofillHints,
            decoration: InputDecoration(
              prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColours.grey, size: 10.sp) : null,
              hintText: hintText,
              suffixIcon: controller.text.isNotEmpty && isObsure
                  ? GestureDetector(
                      onTap: () => isTextObsure.value = !isTextObsure.value,
                      child: isTextObsure.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
