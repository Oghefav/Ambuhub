import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/select_country_form_field.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_form_styles.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/add_service_form_section.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/drop_down_form_field_builder.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServiceOfficeLocationSection extends StatelessWidget {
  final List<Country> countries;
  final ValueNotifier<Country?> selectedCountry;
  final TextEditingController countrySearchController;
  final bool subdivisionsLoading;
  final bool manualStateMode;
  final bool subdivisionsFailed;
  final List<String> stateItems;
  final Map<String, String> stateCodesByName;
  final String selectedStateName;
  final TextEditingController manualStateController;
  final TextEditingController officeAddressController;
  final ValueChanged<Country?> onCountryChanged;
  final void Function(String name, String? code) onStateSelected;
  final ValueChanged<String> onManualChanged;
  final VoidCallback onAddressChanged;

  const AddServiceOfficeLocationSection({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.countrySearchController,
    required this.subdivisionsLoading,
    required this.manualStateMode,
    required this.subdivisionsFailed,
    required this.stateItems,
    required this.stateCodesByName,
    required this.selectedStateName,
    required this.manualStateController,
    required this.officeAddressController,
    required this.onCountryChanged,
    required this.onStateSelected,
    required this.onManualChanged,
    required this.onAddressChanged,
  });

  bool get _hasCountry => selectedCountry.value != null;

  String get _stateHint {
    if (!_hasCountry) return 'Select a country first';
    if (subdivisionsLoading) return 'State is loading';
    if (manualStateMode) return 'Enter state or province';
    return 'Select state / province';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = AddServiceFormStyles.hint(textTheme);

    return AddServiceFormSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OFFICE LOCATION',
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.vividTeal,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          SelectCountryFormField(
            label: 'Country',
            hintText: 'Select country or region',
            searchController: countrySearchController,
            inputType: TextInputType.text,
            value: selectedCountry,
            countries: countries,
            onChanged: onCountryChanged,
            hintStyle: hintStyle,
          ),
          SizedBox(height: 12.h),
          if (manualStateMode) ...[
            Text('State / province', style: AddServiceFormStyles.label(textTheme)),
            SizedBox(height: 5.h),
            TextFormField(
              enabled: _hasCountry,
              controller: manualStateController,
              onChanged: onManualChanged,
              style: hintStyle,
              decoration: InputDecoration(
                hintText: _stateHint,
                hintStyle: hintStyle,
              ),
            ),
            if (subdivisionsFailed && _hasCountry) ...[
              SizedBox(height: 4.h),
              Text(
                'No predefined subdivisions for this country; enter manually.',
                style: hintStyle.copyWith(color: AppColours.grey, fontSize: 9.sp),
              ),
            ],
          ] else
            DropDownFormFieldBuilder(
              value: selectedStateName,
              isEnabled:
                  _hasCountry && !subdivisionsLoading && stateItems.isNotEmpty,
              notEnabledhintText: _stateHint,
              hintText: _stateHint,
              items: stateItems,
              title: 'State / province',
              placeHolder: 'Select state / province',
              onChanged: (value) {
                if (value == null || value.isEmpty) return;
                onStateSelected(value, stateCodesByName[value]);
              },
            ),
          SizedBox(height: 5.h),
          Text('Office address', style: AddServiceFormStyles.label(textTheme)),
          SizedBox(height: 5.h),
          TextFormField(
            controller: officeAddressController,
            onChanged: (_) => onAddressChanged(),
            style: hintStyle,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Street, building, city area',
              hintStyle: hintStyle,
            ),
          ),
        ],
      ),
    );
  }
}
