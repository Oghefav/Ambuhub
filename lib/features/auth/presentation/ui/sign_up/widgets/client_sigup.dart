import 'package:ambuhub/core/validation/form_validators.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/widget/top_section.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/core/widgets/text_field_builder.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/select_country_form_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ClientSignupFormCard extends HookWidget {
  final String role;
  final _formKey = GlobalKey<FormState>();
  ClientSignupFormCard({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final countryController = useTextEditingController();
    final passwordController = useTextEditingController();
    final dateOfBirthController = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final selectedCountry = useState<Country?>(null);
    final selectedCountryCode = useState<String?>(null);
    final countries = CountryService().getAll();
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.providerDashBoardScreen, (route) => false);
        }
        if (state is AuthFailed) {
          print('auth is not successfull');
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const TopSection(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign up as $role',
                      style: textTheme.titleMedium!.copyWith(fontSize: 23.sp),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Email verification with a one-time code will be added soon. For now you can use your account right after signing up.',
                      style: textTheme.bodyMedium,
                    ),
                    SizedBox(height: 20.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldBuilder(
                            label: 'First name',
                            hintText: 'Jane',
                            controller: firstNameController,
                            inputType: TextInputType.name,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Please fill out this field',
                              ),
                            ]),
                          ),
                          TextFieldBuilder(
                            label: 'Last name',
                            hintText: 'Doe',
                            controller: lastNameController,
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
                          Text('Date of birth', style: textTheme.titleSmall),
                          SizedBox(height: 5.h),
                          TextFormField(
                            readOnly: true,
                            controller: dateOfBirthController,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Please fill out this field',
                              ),
                              FormValidators.minimumAge(
                                birthDate: () => selectedDate.value,
                              ),
                            ]),
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              hintText: 'DD/MM/YYYY',
                              suffixIcon: IconButton(
                                onPressed: () => selectDate(
                                  context,
                                  dateOfBirthController,
                                  selectedDate,
                                  lastBirthDate:
                                      FormValidators.latestBirthDateForMinimumAge(),
                                ),
                                icon: const Icon(LucideIcons.calendar),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SelectCountryFormField(
                            value: selectedCountry,
                            countries: countries,
                            searchController: countryController,
                            label: 'Country',
                            hintText: 'Country or region',
                            inputType: TextInputType.text,
                            onChanged: (country) {
                              selectedCountry.value = country;
                              selectedCountryCode.value = country?.countryCode;
                            },
                          ),
                          SizedBox(height: 10.h),
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
                                errorText:
                                    'Please lengthen the text to 8 characters',
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
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
                          buttonText: isLoading
                              ? 'Creating account'
                              : 'Create account',
                          onPressed: () => onSubmitButtonPressed(
                            context,
                            emailController,
                            passwordController,
                            firstNameController,
                            lastNameController,
                            phoneNumberController,
                            selectedCountryCode,
                            role,
                            dateOfBirthController,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            
          ],
        );
      },
    );
  }

  void onSubmitButtonPressed(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
      TextEditingController firstNameController,
      TextEditingController lastNameController,
    TextEditingController phoneNumberController,
    ValueNotifier<String?> selectedCountryCode,
    String role,
    TextEditingController dateOfBirthController,
  ) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        ClientSignUp(
          clientSignUpParams: ClientSignUpParams(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            phone: phoneNumberController.text.trim(),
            country: selectedCountryCode.value! ,
            password: passwordController.text.trim(),
            dateOfBirth: dateOfBirthController.text.trim(),
            role: role.toLowerCase(),
          ),
        ),
      );
    }
  }
}

Future<void> selectDate(
  BuildContext context,
  TextEditingController dateController,
  ValueNotifier<DateTime?> selectedDate, {
  required DateTime lastBirthDate,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    firstDate: DateTime(1950),
    initialDate: _clampDate(
      selectedDate.value ?? lastBirthDate,
      DateTime(1950),
      lastBirthDate,
    ),
    lastDate: lastBirthDate,
    // Customizing the calendar colors to match Ambuhub
    builder: (context, child) {
      return Transform.scale(scale: 0.8, child: child);
    },
  );

  if (picked != null && picked != selectedDate.value) {
    selectedDate.value = picked;
    dateController.text = selectedDate.value?.toString().split(' ')[0] ?? '';
  }
}

DateTime _clampDate(DateTime value, DateTime min, DateTime max) {
  if (value.isBefore(min)) return min;
  if (value.isAfter(max)) return max;
  return value;
}
