import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/widget/role_section.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/widget/top_section.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleScreen extends HookWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roleSelected = useState<String>('');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColours.white,
      body: Column(
        children: [
          GradientBackground(),
          Align(
            alignment: Alignment.center,
            child: _buildBody(context, roleSelected),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ValueNotifier<String> roleSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopSection(),
        RoleSection(roleSelected: roleSelected),
        SizedBox(height: 15.h),
        BottomText(),
      ],
    );
  }
}
