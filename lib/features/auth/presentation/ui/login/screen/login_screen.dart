import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/bottom_text.dart';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:ambuhub/features/auth/presentation/ui/login/widgets/login_form_card.dart';
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
    useEffect(() {
      BlocProvider.of<AuthBloc>(context).add(const AuthReset());
      emailController.clear();
      passwordController.clear();
      return null;
    }, []);
    

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

