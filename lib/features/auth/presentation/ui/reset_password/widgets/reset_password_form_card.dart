import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/domain/entities/reset_password_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/navigation_text.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/core/widgets/text_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ResetPasswordFormCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  ResetPasswordFormCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final texttheme = Theme.of(context).textTheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess && state.data is String) {
          confirmPasswordController.clear();
          passwordController.clear();
        }
      },
      builder: (context, state) {
        return Card(
          elevation: 0,
          margin: EdgeInsets.all(15.w),
          color: AppColours.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(color: AppColours.veryLightVividTeal),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reset password', style: texttheme.titleLarge),
                SizedBox(height: 8.h),
                Text(
                  'Enter the email on your account and choose a new password. This does not send email or OTP—only use on accounts you control.',
                  style: texttheme.bodyMedium,
                ),
                SizedBox(height: 20.h),
                Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        TextFieldBuilder(
                          label: 'Email',
                          hintText: 'You@example.com',
                          controller: emailController,
                          onChanged: (value) => value.trim(),
                          inputType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
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
                          label: 'New password',
                          hintText: 'At least 8 characters',
                          isObsure: true,
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          autofillHints: const [AutofillHints.password],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Please fill out this field',
                            ),
                            FormBuilderValidators.minLength(
                              8,
                              errorText:
                                  'Please lengthen the text to 8 characters',
                            ),
                          ]),
                        ),
                        TextFieldBuilder(
                          label: 'Confirm new password',
                          hintText: 'Repeat new password',
                          isObsure: true,
                          controller: confirmPasswordController,
                          inputType: TextInputType.visiblePassword,
                          onChanged: (value) => value.trim(),
                          autofillHints: const [AutofillHints.newPassword],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Please fill out this field',
                            ),
                            (value) {
                              if (value?.trim() !=
                                  passwordController.text.trim()) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                BlocSelector<AuthBloc, AuthState, String?>(
                  selector: (state) {
                    if (state is AuthSuccess && state.data is String) {
                      return state.data as String;
                    }
                    return null;
                  },
                  builder: (context, message) {
                    if (message == null) {
                      return const SizedBox.shrink();
                    }
                    return successMessage(context, message);
                  },
                ),
                BlocSelector<AuthBloc, AuthState, String?>(
                  selector: (state) => state is AuthFailed ? state.error : null,
                  builder: (context, errorMessage) {
                    if (errorMessage == null) {
                      return const SizedBox.shrink();
                    }
                    return ErrorMessageContainer(errorMessage: errorMessage);
                  },
                ),
                SizedBox(height: 15.h),
                BlocSelector<AuthBloc, AuthState, bool>(
                  selector: (state) => state is AuthLoading,
                  builder: (context, isLoading) {
                    return SubmitButton(
                      onPressed: () {
                        onSubmitButtonPressed(
                          context,
                          emailController,
                          passwordController,
                        );
                      },
                      buttonText: isLoading ? 'Updating' : 'Update password',
                    );
                  },
                ),

                SizedBox(height: 20.h),
                const NavigationText(
                  secondText: 'Back to sign in',
                  routeName: AppRoutes.loginScreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget successMessage(BuildContext context, String message) {
    final texttheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColours.lightMintGreen,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        message,
        style: texttheme.bodySmall!.copyWith(color: AppColours.darkTealAccent),
      ),
    );
  }

  void onSubmitButtonPressed(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        ResetPassword(
          resetPasswordParams: ResetPasswordParams(
            email: emailController.text.trim(),
            newPassword: passwordController.text.trim(),
          ),
        ),
      );
    }
  }
}
