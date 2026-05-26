import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/core/widgets/text_field_builder.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/select_country_form_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ServiceProviderSignupBody extends HookWidget {
  final String role;
  final _formKey = GlobalKey<FormState>();
  ServiceProviderSignupBody({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final countryController = useTextEditingController();
    final businessNameController = useTextEditingController();
    final websiteUrlController = useTextEditingController();
    final physicalAddressController = useTextEditingController();
    final passwordController = useTextEditingController();
    final selectedCountryCode = useState<String?>(null);
    final selectedCountry = useState<Country?>(null);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
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
                        SelectCountryFormField(
                          label: 'Country',
                          value: selectedCountry,
                          hintText: 'Select country',
                          searchController: countryController,
                          inputType: TextInputType.text,
                          onChanged: (country) {
                            selectedCountry.value = country;
                            selectedCountryCode.value = country!.countryCode;
                          },
                          countries: countries,
                        ),
                        SizedBox(height: 10.h),
                        TextFieldBuilder(
                          label: 'Business name',
                          hintText: 'Registered or trading name',
                          controller: businessNameController,
                          inputType: TextInputType.text,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Please fill out this field',
                            ),
                          ]),
                        ),
                        TextFieldBuilder(
                          label: 'Website URL (optional)',
                          hintText: 'https://www.example.com',
                          controller: websiteUrlController,
                          inputType: TextInputType.text,
                          validator: null,
                        ),
                        TextFieldBuilder(
                          label: 'Physical address',
                          hintText: 'Street, City, or region',
                          controller: physicalAddressController,
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
                    selector: (state) =>
                        state is AuthFailed ? state.error : null,
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
                          businessNameController,
                          websiteUrlController,
                          physicalAddressController,
                          selectedCountryCode.value,
                          phoneNumberController,
                          role,
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
    TextEditingController businessNameController,
    TextEditingController websiteUrlController,
    TextEditingController physicalAddressController,
    String? selectedCountryCode,
    TextEditingController phoneNumberController,
    String role,
  ) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        ServiceProviderSignUp(
          serviceProviderSignUpParams: ServiceProviderSignUpParams(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            phone: phoneNumberController.text.trim(),
            country: selectedCountryCode!,
            password: passwordController.text.trim(),
            businessName: businessNameController.text.trim(),
            websiteUrl: websiteUrlController.text.trim(),
            physicalAddress: physicalAddressController.text.trim(),
            role: role.toLowerCase().replaceAll(' ', '_'),
          ),
        ),
      );
    }
  }
}
