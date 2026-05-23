import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/validation/form_validators.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/incomplete_profile_card.dart';
import 'package:ambuhub/core/widgets/text_field_builder.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/profile_action_feedback.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/profile_submit_button.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/entities/update_profile_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/auth/presentation/ui/sign_up/widgets/client_sigup.dart'
    show selectDate;
import 'package:ambuhub/features/auth/presentation/ui/widgets/select_country_form_field.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/utils/client_profile_utils.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/shadow_container_template.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PersonalInfoCard extends HookWidget {
  final ClientEntity client;
  final _formKey = GlobalKey<FormState>();

  PersonalInfoCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isComplete = isClientProfileComplete(client);

    if (!isComplete) {
      return const IncompleteProfileCard();
    }

    final countries = CountryService().getAll();
    final initialDob = useMemoized(
      () => _parseDateOfBirth(client.dateOfBirth),
      [client.dateOfBirth],
    );
    final initialCountry = useMemoized(
      () => _countryFromCode(client.country, countries),
      [client.country],
    );

    final firstNameController = useTextEditingController(text: client.firstName);
    final lastNameController = useTextEditingController(text: client.lastName);
    final emailController = useTextEditingController(text: client.email);
    final phoneNumberController = useTextEditingController(text: client.phone);
    final countrySearchController = useTextEditingController();
    final dateOfBirthController = useTextEditingController(
      text: _formatDateOfBirthField(client.dateOfBirth),
    );
    final selectedDate = useState<DateTime?>(initialDob);
    final selectedCountry = useState<Country?>(initialCountry);
    final selectedCountryCode = useState<String?>(
      initialCountry?.countryCode ?? client.country,
    );
    final showProfileSaved = useState(false);

    return ShadowContainerTemplate(
      bodyColors: [
        AppColours.white,
        Color.lerp(AppColours.veryLightVividTeal, AppColours.white, 0.9)!,
        Color.lerp(AppColours.veryLightVividTeal, AppColours.white, 0.98)!,
        
      ],
      bodyStops:const [0.2, 0.5, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              'Personal information',
              style: textTheme.titleSmall?.copyWith(
                color: AppColours.darkVividTeal,
                fontWeight: FontWeight.w700,
              ),
            ),
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
                    searchController: countrySearchController,
                    label: 'Country',
                    hintText: 'Country or region',
                    inputType: TextInputType.text,
                    onChanged: (country) {
                      selectedCountry.value = country;
                      selectedCountryCode.value = country?.countryCode;
                    },
                  ),
                ],
              ),
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  previous is AuthSuccess &&
                  current is AuthSuccess &&
                  previous.isProfileUpdating &&
                  !current.isProfileUpdating,
              listener: (_, state) {
                if (state is AuthSuccess) {
                  showProfileSaved.value = state.profileError == null;
                }
              },
              builder: (context, state) {
                final isSaving =
                    state is AuthSuccess && state.isProfileUpdating;
                final profileError = state is AuthSuccess
                    ? state.profileError
                    : state is AuthFailed
                        ? state.error
                        : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    ProfileActionFeedback(
                      errorMessage: profileError,
                      showSuccess: showProfileSaved.value,
                      successMessage: 'Profile saved',
                    ),
                    ProfileSubmitButton(
                      label: isSaving ? 'Saving' : 'Save changes',
                      isLoading: isSaving,
                      onPressed: isSaving
                          ? null
                          : () => _onSavePressed(
                                context,
                                showProfileSaved,
                                firstNameController,
                                lastNameController,
                                emailController,
                                phoneNumberController,
                                selectedCountryCode,
                                dateOfBirthController,
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

  void _onSavePressed(
    BuildContext context,
    ValueNotifier<bool> showProfileSaved,
    TextEditingController firstNameController,
    TextEditingController lastNameController,
    TextEditingController emailController,
    TextEditingController phoneNumberController,
    ValueNotifier<String?> selectedCountryCode,
    TextEditingController dateOfBirthController,
  ) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedCountryCode.value == null ||
        selectedCountryCode.value!.trim().isEmpty) {
      return;
    }

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess && authState.isProfileUpdating) {
      return;
    }

    showProfileSaved.value = false;
    context.read<AuthBloc>().add(
          UpdateProfile(
            updateProfileParams: UpdateProfileParams(
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              email: emailController.text.trim(),
              phone: phoneNumberController.text.trim(),
              country: selectedCountryCode.value!.trim(),
              dateOfBirth: dateOfBirthController.text.trim(),
            ),
          ),
        );
  }
}

DateTime? _parseDateOfBirth(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  return DateTime.tryParse(trimmed.split(' ').first);
}

String _formatDateOfBirthField(String raw) {
  final parsed = _parseDateOfBirth(raw);
  if (parsed == null) {
    return raw.trim();
  }
  return parsed.toString().split(' ')[0];
}

Country? _countryFromCode(String code, List<Country> countries) {
  if (code.trim().isEmpty) {
    return null;
  }
  final normalized = code.trim().toUpperCase();
  for (final country in countries) {
    if (country.countryCode.toUpperCase() == normalized) {
      return country;
    }
  }
  return null;
}
