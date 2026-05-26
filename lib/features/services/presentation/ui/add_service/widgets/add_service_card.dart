import 'dart:io';

import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_state.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_category_rules.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_form_readiness.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_form_styles.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_pricing_period.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_state_loader.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_time_utils.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/add_service_hire_section.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/add_service_office_location_section.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/drop_down_form_field_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/photo_section.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/submit_buttom.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class AddServiceFormCard extends HookWidget {
  AddServiceFormCard({super.key});

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final categoriesState = context.watch<GetServiceCategoriesBloc>().state;
    final categories =
        categoriesState.serviceCategories?.map((e) => e).toList() ?? [];
    final categoryNames = categories
        .map((e) => e.name.trim())
        .where((name) => name.isNotEmpty)
        .toList();
    final categoriesLoading = categoriesState is GetServiceCategoriesLoading;
    final categoriesReady = categoryNames.isNotEmpty;
    final countries = useMemoized(() => CountryService().getAll());

    final selectedCategory = useState('');
    final selectedDept = useState('');
    final titleController = useTextEditingController();
    final stockController = useTextEditingController();
    final priceController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final filePaths = useState<List<String>>([]);
    final selectedImages = useState<List<File>>([]);
    final isFormValid = useState<bool>(false);
    final selectedListType = useState('');
    final textTheme = Theme.of(context).textTheme;

    final selectedCountry = useState<Country?>(null);
    final countrySearchController = useTextEditingController();
    final officeAddressController = useTextEditingController();
    final manualStateController = useTextEditingController();
    final selectedStateName = useState('');
    final selectedStateCode = useState<String?>(null);
    final subdivisionsLoading = useState(false);
    final manualStateMode = useState(false);
    final subdivisionsFailed = useState(false);
    final stateItems = useState<List<String>>([]);
    final stateCodesByName = useState<Map<String, String>>({});

    final selectedPricingPeriod =
        useState<String>(kPricingPeriodPlaceholder);
    final selectedReturnDays = useState<Set<int>>({1, 2, 3, 4, 5});
    final returnFrom = useState(TimeOfDay(hour: 9, minute: 0));
    final returnUntil = useState(TimeOfDay(hour: 16, minute: 0));
    final returnTimeError = useState<String?>(null);
    final returnFromController =
        useTextEditingController(text: formatTimeOfDayDisplay(returnFrom.value));
    final returnUntilController = useTextEditingController(
      text: formatTimeOfDayDisplay(returnUntil.value),
    );

    final listingLocked =
        AddServiceCategoryRules.isListingTypeLocked(selectedCategory.value);
    final listingOptions =
        AddServiceCategoryRules.listingTypeOptions(selectedCategory.value);
    final isHire = AddServiceCategoryRules.isHire(selectedListType.value);
    final isSale = AddServiceCategoryRules.isSale(selectedListType.value);
    final isStockEnabled =
        AddServiceCategoryRules.areStockAndPriceAllowed(selectedListType.value);
    final isPriceEnabled = isStockEnabled;
    final stockPriceDisabledHint =
        AddServiceCategoryRules.stockAndPriceDisabledHint(
      category: selectedCategory.value,
      listingType: selectedListType.value,
    );
    final stockRequired = isSale;
    final priceRequired = isSale;

    void updateReadiness() {
      Future.microtask(() {
        isFormValid.value = isAddServiceFormReady(
          selectedCategory: selectedCategory.value,
          selectedDept: selectedDept.value,
          selectedListType: selectedListType.value,
          selectedCountry: selectedCountry.value,
          manualStateMode: manualStateMode.value,
          manualStateText: manualStateController.text,
          selectedStateName: selectedStateName.value,
          officeAddress: officeAddressController.text,
          title: titleController.text,
          description: descriptionController.text,
          isHire: isHire,
          selectedPricingPeriod: selectedPricingPeriod.value,
          selectedReturnDays: selectedReturnDays.value,
          returnFrom: returnFrom.value,
          returnUntil: returnUntil.value,
          stockText: stockController.text,
          priceText: priceController.text,
          stockRequired: stockRequired,
          priceRequired: priceRequired,
        );
      });
    }

    Future<void> loadSubdivisions(String countryCode) async {
      selectedStateName.value = '';
      selectedStateCode.value = null;
      manualStateController.clear();
      stateItems.value = [];
      stateCodesByName.value = {};
      manualStateMode.value = false;
      subdivisionsFailed.value = false;
      subdivisionsLoading.value = true;

      try {
        final loaded = await loadStatesForCountry(countryCode);
        if (loaded.names.isEmpty) {
          manualStateMode.value = true;
          subdivisionsFailed.value = true;
        } else {
          stateItems.value = loaded.names;
          stateCodesByName.value = loaded.codesByName;
        }
      } catch (_) {
        manualStateMode.value = true;
        subdivisionsFailed.value = true;
      } finally {
        subdivisionsLoading.value = false;
        updateReadiness();
      }
    }

    void applyCategoryListingRules(String categoryName) {
      final forced = AddServiceCategoryRules.forcedListingType(categoryName);
      selectedListType.value = forced ?? '';
      if (!AddServiceCategoryRules.isHire(forced ?? '')) {
        selectedPricingPeriod.value = kPricingPeriodPlaceholder;
      }
      if (!isSale && !AddServiceCategoryRules.isHire(forced ?? '')) {
        stockController.clear();
        priceController.clear();
      }
    }

    useEffect(() {
      updateReadiness();
      return null;
    }, []);

    useEffect(() {
      void listener() => updateReadiness();
      titleController.addListener(listener);
      descriptionController.addListener(listener);
      stockController.addListener(listener);
      priceController.addListener(listener);
      return () {
        titleController.removeListener(listener);
        descriptionController.removeListener(listener);
        stockController.removeListener(listener);
        priceController.removeListener(listener);
      };
    }, []);

    useEffect(() {
      applyCategoryListingRules(selectedCategory.value);
      updateReadiness();
      return null;
    }, [selectedCategory.value]);

    useEffect(() {
      if (!isHire) {
        returnTimeError.value = null;
      } else {
        returnTimeError.value = isReturnWindowValid(
          returnFrom.value,
          returnUntil.value,
        )
            ? null
            : 'Return until must be after return from';
      }
      updateReadiness();
      return null;
    }, [selectedListType.value, returnFrom.value, returnUntil.value]);

    Future<void> pickFile() async {
      final List<XFile?> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.value = images.map((e) => File(e!.path)).toList();
        filePaths.value = images.map((e) => p.basename(e!.path)).toList();
      }
    }

    List<String> getDepartments() {
      if (selectedCategory.value.isEmpty) return [];
      final match = categories.firstWhere(
        (e) => e.name == selectedCategory.value,
      );
      return match.departments.map((e) => e.name).toList();
    }

    int? parseOptionalInt(String raw) {
      final trimmed = raw.trim();
      if (trimmed.isEmpty) return null;
      return int.tryParse(trimmed);
    }

    return Card(
      color: AppColours.white,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropDownFormFieldBuilder(
                    value: selectedCategory.value,
                    isEnabled: categoriesReady && !categoriesLoading,
                    title: 'Service category',
                    hintText: 'Select a category',
                    notEnabledhintText: categoriesLoading
                        ? 'Loading categories...'
                        : 'Categories unavailable',
                    items: categoryNames,
                    placeHolder: 'Select a category',
                    onChanged: (value) {
                      if (value != null) {
                        selectedDept.value = '';
                        selectedCategory.value = value;
                        applyCategoryListingRules(value);
                      } else {
                        selectedCategory.value = '';
                        selectedListType.value = '';
                      }
                      updateReadiness();
                    },
                  ),
                  SizedBox(height: 15.h),
                  DropDownFormFieldBuilder(
                    value: selectedDept.value,
                    hintText: 'Select a department',
                    isEnabled: selectedCategory.value.isNotEmpty,
                    notEnabledhintText: 'Choose a category first',
                    items: getDepartments(),
                    onChanged: (value) {
                      if (value != null) {
                        selectedDept.value = value;
                        updateReadiness();
                      }
                    },
                    title: 'Department (sub-category)',
                    placeHolder: 'Select a department',
                  ),
                  SizedBox(height: 15.h),
                  AddServiceOfficeLocationSection(
                    countries: countries,
                    selectedCountry: selectedCountry,
                    countrySearchController: countrySearchController,
                    subdivisionsLoading: subdivisionsLoading.value,
                    manualStateMode: manualStateMode.value,
                    subdivisionsFailed: subdivisionsFailed.value,
                    stateItems: stateItems.value,
                    stateCodesByName: stateCodesByName.value,
                    selectedStateName: selectedStateName.value,
                    manualStateController: manualStateController,
                    officeAddressController: officeAddressController,
                    onCountryChanged: (country) {
                      selectedCountry.value = country;
                      if (country != null) {
                        loadSubdivisions(country.countryCode);
                      } else {
                        selectedStateName.value = '';
                        selectedStateCode.value = null;
                        manualStateController.clear();
                        stateItems.value = [];
                        stateCodesByName.value = {};
                        manualStateMode.value = false;
                        subdivisionsLoading.value = false;
                        subdivisionsFailed.value = false;
                      }
                      updateReadiness();
                    },
                    onStateSelected: (name, code) {
                      selectedStateName.value = name;
                      selectedStateCode.value = code;
                      updateReadiness();
                    },
                    onManualChanged: (_) => updateReadiness(),
                    onAddressChanged: updateReadiness,
                  ),
                  SizedBox(height: 15.h),
                  DropDownFormFieldBuilder(
                    value: selectedListType.value,
                    hintText: 'Select a listing type',
                    isEnabled: selectedCategory.value.isNotEmpty && !listingLocked,
                    notEnabledhintText:
                        AddServiceCategoryRules.listingTypeDisabledHint(
                      selectedCategory.value,
                    ),
                    items: listingOptions,
                    onChanged: (value) {
                      selectedListType.value = value ?? '';
                      updateReadiness();
                    },
                    title: 'Listing type',
                    placeHolder: 'Select a listing type',
                  ),
                  SizedBox(height: 15.h),
                  Text('Stock', style: AddServiceFormStyles.label(textTheme)),
                  SizedBox(height: 5.h),
                  TextFormField(
                    enabled: isStockEnabled,
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    style: AddServiceFormStyles.hint(textTheme),
                    decoration: InputDecoration(
                      hintText: !isStockEnabled
                          ? stockPriceDisabledHint
                          : isHire
                              ? 'Optional — units available to hire'
                              : 'Enter stock quantity',
                      hintStyle: AddServiceFormStyles.hint(textTheme),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text('Price (NGN)', style: AddServiceFormStyles.label(textTheme)),
                  SizedBox(height: 5.h),
                  TextFormField(
                    enabled: isPriceEnabled,
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    style: AddServiceFormStyles.hint(textTheme),
                    decoration: InputDecoration(
                      hintText: !isPriceEnabled
                          ? stockPriceDisabledHint
                          : isHire
                              ? 'Optional — hire rate in naira'
                              : 'Enter price in naira',
                      hintStyle: AddServiceFormStyles.hint(textTheme),
                    ),
                  ),
                  if (isHire) ...[
                    SizedBox(height: 15.h),
                    AddServiceHireSection(
                      selectedPricingPeriod: selectedPricingPeriod,
                      selectedReturnDays: selectedReturnDays,
                      returnFrom: returnFrom,
                      returnUntil: returnUntil,
                      returnTimeError: returnTimeError,
                      returnFromController: returnFromController,
                      returnUntilController: returnUntilController,
                      onChanged: updateReadiness,
                    ),
                  ],
                  SizedBox(height: 15.h),
                  Text('Title', style: AddServiceFormStyles.label(textTheme)),
                  SizedBox(height: 5.h),
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    style: AddServiceFormStyles.hint(textTheme),
                    decoration: InputDecoration(
                      hintText: 'e.g. Event medical standby - 2 ambulances',
                      hintStyle: AddServiceFormStyles.hint(textTheme),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Description',
                    style: AddServiceFormStyles.label(textTheme),
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    style: AddServiceFormStyles.hint(textTheme),
                    decoration: InputDecoration(
                      hintText:
                          'Coverage area, crew size, vehicle types, pricing notes...',
                      hintStyle: AddServiceFormStyles.hint(textTheme),
                    ),
                  ),
                ],
              ),
            ),
            PhotoSection(
              isUpdate: false,
              hintText:
                  'Images only (JPEG, PNG, WebP, etc.). Up to 10 files, 5MB each.',
              selectedImages: selectedImages.value,
              filePaths: filePaths.value,
              onTap: () async => await pickFile(),
            ),
            SizedBox(height: 15.h),
            BlocSelector<AddServiceBloc, AddServiceState, String?>(
              selector: (state) =>
                  state is AddServiceError ? state.errorMessage : null,
              builder: (context, errorMessage) {
                if (errorMessage == null) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.w),
                  child: ErrorMessageContainer(errorMessage: errorMessage),
                );
              },
            ),
            BlocListener<AddServiceBloc, AddServiceState>(
              listener: (context, state) {
                if (state is AddServiceSuccess) {
                  BlocProvider.of<GetProviderServicesBloc>(context)
                      .invalidateProviderListings();
                  BlocProvider.of<GetProviderServicesBloc>(context).add(
                    const GetProviderServices(forceRefresh: true),
                  );
                  BlocProvider.of<NavigationCubit>(context).setPage('listings');
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.listingsScreen,
                  );
                }
              },
              child: BlocSelector<AddServiceBloc, AddServiceState, bool>(
                selector: (state) => state is AddServiceLoading,
                builder: (context, isLoading) {
                  final canPublish = isFormValid.value && !isLoading;

                  return ServiceSubmitButton(
                    buttonText: isLoading
                        ? 'Publishing service'
                        : 'Publish service',
                    onPressed: canPublish
                        ? () {
                            final category = categories.firstWhere(
                              (e) => e.name == selectedCategory.value,
                            );
                            final dept = category.departments.firstWhere(
                              (e) => e.name == selectedDept.value,
                            );

                            final stateProvince = manualStateMode.value
                                ? manualStateController.text.trim()
                                : (selectedStateCode.value ??
                                    selectedStateName.value);
                            final stateName = manualStateMode.value
                                ? manualStateController.text.trim()
                                : selectedStateName.value;

                            BlocProvider.of<AddServiceBloc>(context).add(
                              AddService(
                                service: ServiceParams(
                                  dept: dept.slug,
                                  description:
                                      descriptionController.text.trim(),
                                  photoUrls: selectedImages.value,
                                  serviceCategory: category.slug,
                                  title: titleController.text.trim(),
                                  stock: parseOptionalInt(stockController.text),
                                  price: parseOptionalInt(priceController.text),
                                  listingType: selectedListType.value,
                                  country: normalizeIso3166Alpha2(
                                    selectedCountry.value!.countryCode,
                                  ),
                                  stateProvince: stateProvince,
                                  stateProvinceName: stateName,
                                  officeAddress:
                                      officeAddressController.text.trim(),
                                  pricePeriod: isHire
                                      ? pricingPeriodLabelToApi(
                                          selectedPricingPeriod.value,
                                        )
                                      : null,
                                  hireReturnWindow: isHire
                                      ? buildHireReturnWindow(
                                          days: selectedReturnDays.value,
                                          from: returnFrom.value,
                                          until: returnUntil.value,
                                        )
                                      : null,
                                ),
                              ),
                            );
                          }
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
