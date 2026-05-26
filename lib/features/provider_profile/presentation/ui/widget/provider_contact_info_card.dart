import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/text_field_builder.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/domain/entities/update_provider_profile_params.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/select_country_form_field.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/incomplete_profile_card.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/profile_action_feedback.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/profile_submit_button.dart';
import 'package:ambuhub/features/provider_profile/presentation/ui/utils/provider_profile_utils.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/shadow_container_template.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ProviderContactInfoCard extends HookWidget {
  final ServiceProviderEntity provider;
  final _formKey = GlobalKey<FormState>();

  ProviderContactInfoCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isComplete = isProviderProfileComplete(provider);

    if (!isComplete) {
      return const IncompleteProfileCard();
    }

    final countries = CountryService().getAll();
    final initialCountry = useMemoized(
      () => _countryFromCode(provider.country, countries),
      [provider.country],
    );

    final firstNameController =
        useTextEditingController(text: provider.firstName);
    final lastNameController = useTextEditingController(text: provider.lastName);
    final phoneNumberController = useTextEditingController(text: provider.phone);
    final countrySearchController = useTextEditingController();
    final businessNameController =
        useTextEditingController(text: provider.businessName);
    final websiteUrlController =
        useTextEditingController(text: provider.websiteUrl ?? '');
    final physicalAddressController =
        useTextEditingController(text: provider.physicalAddress);
    final selectedCountry = useState<Country?>(initialCountry);
    final selectedCountryCode = useState<String?>(
      initialCountry?.countryCode ?? provider.country,
    );
    final showProfileSaved = useState(false);

    return ShadowContainerTemplate(
      bodyColors: [
        AppColours.white,
        Color.lerp(AppColours.veryLightVividTeal, AppColours.white, 0.9)!,
        Color.lerp(AppColours.veryLightVividTeal, AppColours.white, 0.98)!,
      ],
      bodyStops: const [0.2, 0.5, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'Contact person',
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.darkVividTeal,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Primary contact for your business on Ambuhub.',
            style: textTheme.bodySmall?.copyWith(
              color: AppColours.grey,
              height: 1.35,
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
                SizedBox(height: 14.h),
                Divider(color: AppColours.veryLightGrey, height: 1),
                SizedBox(height: 14.h),
                Text(
                  'Business details',
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColours.darkVividTeal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
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
                  inputType: TextInputType.url,
                  validator: null,
                ),
                TextFieldBuilder(
                  label: 'Physical address',
                  hintText: 'Street, City, or region',
                  controller: physicalAddressController,
                  inputType: TextInputType.streetAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Please fill out this field',
                    ),
                  ]),
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
                              phoneNumberController,
                              selectedCountryCode,
                              businessNameController,
                              websiteUrlController,
                              physicalAddressController,
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
    TextEditingController phoneNumberController,
    ValueNotifier<String?> selectedCountryCode,
    TextEditingController businessNameController,
    TextEditingController websiteUrlController,
    TextEditingController physicalAddressController,
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

    final website = websiteUrlController.text.trim();

    showProfileSaved.value = false;
    context.read<AuthBloc>().add(
          UpdateProviderProfile(
            updateProviderProfileParams: UpdateProviderProfileParams(
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              phone: phoneNumberController.text.trim(),
              country: selectedCountryCode.value!.trim(),
              businessName: businessNameController.text.trim(),
              websiteUrl: website.isEmpty ? null : website,
              physicalAddress: physicalAddressController.text.trim(),
            ),
          ),
        );
  }
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
