import 'package:ambuhub/core/hooks/use_route_aware.dart';
import 'package:ambuhub/core/utililty/app_route_observer.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:ambuhub/features/auth/presentation/ui/login/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    void resetLoginForm() {
      emailController.clear();
      passwordController.clear();
      context.read<AuthBloc>().add(const AuthReset());
    }

    useRouteAware(
      observer: appRouteObserver,
      onDidPush: resetLoginForm,
      onDidPopNext: resetLoginForm,
    );
    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: 
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginBody(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                SizedBox(height: 25.h),
                const BottomText(),
              ],
            ),
          ),
    );
  }
}

