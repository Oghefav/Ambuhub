import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/gradient_background.dart';
import 'package:ambuhub/features/auth/presentation/ui/login/widgets/login_form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends HookWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // These remain here if you need them for a "Sign In" button logic
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const GradientBackground(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginFormCard(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                SizedBox(height: 25.h),
                const BottomText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

