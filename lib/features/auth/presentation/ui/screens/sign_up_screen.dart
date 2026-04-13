import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/gradient_background.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/signup_form_card.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final String role;
  const SignUpScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              GradientBackground(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SignupFormCard(role: role),
                    BottomText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
