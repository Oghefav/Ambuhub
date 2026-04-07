import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends HookWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      body: Center(
        child: _buildLoginCard(context, emailController, passwordController)),
    );
  }

  Widget _buildLoginCard(BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
    return  Card(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Log in', style: Theme.of(context).textTheme.displayMedium),
                SizedBox(height: 10.h),
                Text(
                  'Access your Ambuhub account with your email and password.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 15.h),
                _buildForm(context, emailController, passwordController),
            
                // Add error message from server here
              ],
            ),
          ),
        );
      
  }

  Widget _buildForm(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start
        ,
        children: [
          _formFieldBuilder(
            context,
            emailController,
            'Email',
            'You@example.com',
            false,
          ),
          _formFieldBuilder(
            context,
            passwordController,
            'Password',
            'Your Password',
            true,
          ),
        ],
      ),
    );
  }

  Widget _formFieldBuilder(
    BuildContext context,
    TextEditingController controller,
    String label,
    String hintText,
    bool obsure,
  ) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        TextFormField(
          controller: controller,
          obscureText: obsure ? true : false,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
