import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/navigation_text.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/submit_button.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/text_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginFormCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  LoginFormCard({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(15.w),
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Log in', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 8.h),
            Text(
              'Access your Ambuhub account with your email and password.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldBuilder(
                    label: 'Email',
                    hintText: 'You@example.com',
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                      FormBuilderValidators.email(
                        errorText: 'Please enter a valid email',
                      ),
                    ]),
                  ),
                  TextFieldBuilder(
                    label: 'Password',
                    hintText: 'Your Password',
                    isObsure: true,
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  print('auth is successful');
                }
                if (state is AuthFailed) {
                  print('auth is not successfull');
                }
              },
              builder: (context, state) {
                return SubmitButton(
                  onPressed:(){ onSubmitButtonPressed(
                    context,
                    emailController,
                    passwordController,
                  );},
                    buttonText: state is AuthLoading ? 'Signing in' : 'Sign in',
                  );
                
              },
            ),
            SizedBox(height: 20.h),
            const NavigationText(
              firstText: 'Don\'t have an account? ',
              secondText: 'Sign up',
              routeName: AppRoutes.roleScreen,
            ),
          ],
        ),
      ),
    );
  }

  void onSubmitButtonPressed(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        Login(
          loginParams: LoginParams(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        ),
      );
    }
  }
}
