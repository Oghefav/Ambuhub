import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_pricing_period.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_time_utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

/// Checks whether the add-service form is complete (no [Form.validate] / no field errors).
bool isAddServiceFormReady({
  required String selectedCategory,
  required String selectedDept,
  required String selectedListType,
  required Country? selectedCountry,
  required bool manualStateMode,
  required String manualStateText,
  required String selectedStateName,
  required String officeAddress,
  required String title,
  required String description,
  required bool isHire,
  required String selectedPricingPeriod,
  required Set<int> selectedReturnDays,
  required TimeOfDay returnFrom,
  required TimeOfDay returnUntil,
  required String stockText,
  required String priceText,
  required bool stockRequired,
  required bool priceRequired,
}) {
  if (selectedCategory.isEmpty ||
      selectedDept.isEmpty ||
      selectedListType.isEmpty ||
      selectedCountry == null ||
      officeAddress.trim().isEmpty ||
      title.trim().isEmpty ||
      description.trim().isEmpty) {
    return false;
  }

  if (manualStateMode) {
    if (manualStateText.trim().isEmpty) return false;
  } else if (selectedStateName.isEmpty) {
    return false;
  }

  if (stockRequired && stockText.trim().isEmpty) return false;
  if (priceRequired && priceText.trim().isEmpty) return false;

  if (isHire) {
    if (selectedPricingPeriod == kPricingPeriodPlaceholder ||
        selectedPricingPeriod.isEmpty ||
        selectedReturnDays.isEmpty ||
        !isReturnWindowValid(returnFrom, returnUntil)) {
      return false;
    }
  }

  return true;
}
