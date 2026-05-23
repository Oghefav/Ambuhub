import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/text_field_builder.dart';
import 'package:ambuhub/features/auth/domain/entities/change_password_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/profile_action_feedback.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/profile_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ChangePasswordSection extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  ChangePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final showPasswordSaved = useState(false);

    return Container(
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColours.hireCyanIce),
        ),
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.shield,
                  color: AppColours.hireCyanIce,
                  size: 20.sp,
                ),
                Text(
                  'Security',
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColours.vividTeal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Change your password. You will stay signed in on this device.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColours.grey,
                height: 1.4,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldBuilder(
                    label: 'Current password',
                    hintText: 'Your current password',
                    isObsure: true,
                    controller: currentPasswordController,
                    inputType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.password],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                    ]),
                  ),
                  TextFieldBuilder(
                    label: 'New password',
                    hintText: 'At least 8 characters',
                    isObsure: true,
                    controller: newPasswordController,
                    inputType: TextInputType.visiblePassword,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    autofillHints: const [AutofillHints.newPassword],
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
                  TextFieldBuilder(
                    label: 'Confirm new password',
                    hintText: 'Repeat new password',
                    isObsure: true,
                    controller: confirmPasswordController,
                    inputType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Please fill out this field',
                      ),
                      (value) {
                        if (value?.trim() !=
                            newPasswordController.text.trim()) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ]),
                  ),
                ],
              ),
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  previous is AuthSuccess &&
                  current is AuthSuccess &&
                  previous.isPasswordUpdating &&
                  !current.isPasswordUpdating,
              listener: (_, state) {
                if (state is AuthSuccess) {
                  final succeeded = state.passwordError == null;
                  showPasswordSaved.value = succeeded;
                  if (succeeded) {
                    currentPasswordController.clear();
                    newPasswordController.clear();
                    confirmPasswordController.clear();
                  }
                }
              },
              builder: (context, state) {
                final isUpdating =
                    state is AuthSuccess && state.isPasswordUpdating;
                final passwordError = state is AuthSuccess
                    ? state.passwordError
                    : state is AuthFailed
                        ? state.error
                        : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    ProfileActionFeedback(
                      errorMessage: passwordError,
                      showSuccess: showPasswordSaved.value,
                      successMessage: 'Password saved',
                    ),
                    ProfileSubmitButton(
                      style: ProfileSubmitButtonStyle.outline,
                      label: isUpdating ? 'Updating' : 'Update password',
                      isLoading: isUpdating,
                      onPressed: isUpdating
                          ? null
                          : () => _onUpdatePasswordPressed(
                                context,
                                showPasswordSaved,
                                currentPasswordController,
                                newPasswordController,
                              ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
  }

  void _onUpdatePasswordPressed(
    BuildContext context,
    ValueNotifier<bool> showPasswordSaved,
    TextEditingController currentPasswordController,
    TextEditingController newPasswordController,
  ) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess && authState.isPasswordUpdating) {
      return;
    }

    showPasswordSaved.value = false;
    context.read<AuthBloc>().add(
          ChangePassword(
            changePasswordParams: ChangePasswordParams(
              currentPassword: currentPasswordController.text.trim(),
              newPassword: newPasswordController.text.trim(),
            ),
          ),
        );
  }
}
