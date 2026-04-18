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
  final FormFieldValidator<String> validator;

  const TextFieldBuilder({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isObsure = false,
    required this.inputType,
    this.maxLines,
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
          Text(label, style: Theme.of(context).textTheme.titleSmall),
          SizedBox(height: 5.h),
          TextFormField(
            controller: controller,
            obscureText: isTextObsure.value,
            validator: validator,
            keyboardType: inputType,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: controller.text.isNotEmpty && isObsure
                  ? GestureDetector(
                      onTap: () => isTextObsure.value = !isTextObsure.value,
                      child: isTextObsure.value
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
