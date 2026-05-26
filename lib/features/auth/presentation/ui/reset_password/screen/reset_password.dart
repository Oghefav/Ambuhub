import 'package:ambuhub/core/hooks/use_route_aware.dart';
import 'package:ambuhub/core/utililty/app_route_observer.dart';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/ui/reset_password/widgets/reset_password_body.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends HookWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    useRouteAware(
      observer: appRouteObserver,
      onDidPush: () {
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        context.read<AuthBloc>().add(const AuthReset());
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const GradientBackground(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ResetPasswordBody(
                  confirmPasswordController: confirmPasswordController,
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
