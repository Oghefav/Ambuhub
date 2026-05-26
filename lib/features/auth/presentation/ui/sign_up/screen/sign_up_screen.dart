import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/presentation/ui/sign_up/widgets/client_sigup.dart';
import 'package:ambuhub/features/auth/presentation/ui/sign_up/widgets/service_provider_signup_form.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final String role;
  const SignUpScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Center(
                child: Column(
                  children: [
                    if (role == 'Client') ClientSignupBody(role: role) else ServiceProviderSignupBody(role: role),
                    const BottomText(),
                  ],
                ),  
              ),
        ),
      ),
    );
  }
}


