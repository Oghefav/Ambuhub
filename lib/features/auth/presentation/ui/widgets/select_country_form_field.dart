import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SelectCountryFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController searchController;
  final TextInputType inputType;
  final ValueNotifier<Country?> value;
  final Function(Country?) onChanged;
  final List<Country> countries;

  const SelectCountryFormField({
    super.key,
    required this.searchController,
    required this.label,
    required this.hintText,
    required this.inputType,
    required this.value,
    required this.onChanged,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    // We use ValueListenableBuilder to ensure the UI updates when 'value' changes
    return ValueListenableBuilder<Country?>(
      valueListenable: value,
      builder: (context, selectedCountry, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 5.h),
            DropdownButtonFormField2<Country>(
              // FIX 1: Explicitly set the 'value' so the field knows what is selected
              valueListenable: value,
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              hint: Text(hintText),
              style: Theme.of(context).textTheme.bodyMedium,

              // FIX 2: Use DropdownMenuItem2 (standard for this package)
              items: countries
                  .map(
                    (country) => DropdownItem<Country>(
                      value: country,
                      child: Row(
                        children: [
                          Text(country.flagEmoji),
                          SizedBox(width: 10.w),
                          Expanded(child: Text(country.name)),
                          Text(
                            country.countryCode,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,

              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: 'Please select a country',
                ),
              ]),

              dropdownStyleData: DropdownStyleData(
                maxHeight: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.white,
                ),
                offset: const Offset(0, -5),
              ),

              dropdownSearchData: DropdownSearchData(
                searchController: searchController,
                // FIX 3: In newer versions, it's 'searchInnerWidget' not 'searchBarWidget'
                searchBarWidgetHeight: 50.h,
                searchBarWidget: Container(
                  height: 50.h,
                  padding: EdgeInsets.all(8.r),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      hintText: 'Search countries',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  final country = item.value as Country;
                  return country.name.toLowerCase().contains(
                        searchValue.toLowerCase(),
                      ) ||
                      country.countryCode.toLowerCase().contains(
                        searchValue.toLowerCase(),
                      );
                },
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) searchController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
