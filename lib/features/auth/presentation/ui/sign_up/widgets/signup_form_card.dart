import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/submit_button.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/text_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignupFormCard extends StatelessWidget {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  final passwordController = TextEditingController();
  final String role;
  final _formKey = GlobalKey<FormState>();
  SignupFormCard({super.key, required this.role});

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
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Back to role choice',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColours.teal),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'Sign up as $role',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: 23.sp),
            ),
            SizedBox(height: 15.h),
            Text(
              'Email verification with a one-time code will be added soon. For now you can use your account right after signing up.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldBuilder(
                    label: 'Full name',
                    hintText: 'Jane Doe',
                    controller: fullNameController,
                    inputType: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                    ]),
                  ),
                  TextFieldBuilder(
                    label: 'Email',
                    hintText: 'you@Example.com',
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
                    label: 'Phone number',
                    hintText: '+1 555 000 0000',
                    controller: phoneNumberController,
                    inputType: TextInputType.phone,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                    ]),
                  ),
                  TextFieldBuilder(
                    label: 'Country',
                    hintText: 'Country or region',
                    controller: countryController,
                    inputType: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                    ]),
                  ),
                  TextFieldBuilder(
                    label: 'Password',
                    hintText: 'At least 8 characters',
                    controller: passwordController,
                    isObsure: true,
                    inputType: TextInputType.visiblePassword,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                      FormBuilderValidators.minLength(
                        8,
                        errorText: 'Please lengthen the text to 8 characters',
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return SubmitButton(
                  buttonText: state is AuthLoading
                      ? 'Creating account'
                      : 'Create account',
                  onPressed: () => onSubmitButtonPressed(
                    context,
                    emailController,
                    passwordController,
                    fullNameController,
                    phoneNumberController,
                    countryController,
                    role,
                  ),
                );
              },
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
    TextEditingController fullNameController,
    TextEditingController phoneNumberController,
    TextEditingController countryController,
    String role,
  ) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUp(
          signUpParams: SignUpParams(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            phone: phoneNumberController.text.trim(),
            country: countryController.text.trim(),
            role: role.trim().toLowerCase().replaceAll(' ', '_'),
            name: fullNameController.text.trim(),
          ),
        ),
      );
    }
  }
}
