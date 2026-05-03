import 'dart:io';
import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_event.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/drop_down_form_field_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/photo_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class AddServiceFormCard extends HookWidget {
  AddServiceFormCard({super.key});

  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final List<String> listType = ['Sale', 'Rent'];

  @override
  Widget build(BuildContext context) {
    final categoriesData = context.read<GetServiceCatBloc>().state.categories;
    final categories = categoriesData?.map((e) => e).toList() ?? [];
    final categoryNames = categoriesData?.map((e) => e.name).toList() ?? [];
    final selectedCategory = useState<String>('');
    final selectedDept = useState<String>('');
    final titleController = useTextEditingController();
    final stockController = useTextEditingController();
    final priceController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final filePaths = useState<List<String>>([]);
    final selectedImages = useState<List<File>>([]);
    final isFormValid = useState<bool>(false);
    final isListingTypeEnabled = useState<bool>(false);
    final isStockEnabled = useState<bool>(false);
    final selectedListType = useState<String>('');
    final notEnabledListTypeHintText = useState<String>(
      'Choose a category first',
    );
    final isResetting = useState<bool>(false);

    void _validate() {
      if (isResetting.value) return;
      Future.microtask((() {
        isFormValid.value = _formKey.currentState?.validate() ?? false;
      }));
    }

    useEffect(() {
      bool isFirstRun = true;
      void listener() {
        if (isFirstRun) {
          isFirstRun = false;
          return;
        }
        _validate();
      }

      titleController.addListener(listener);
      descriptionController.addListener(listener);
      return () {
        titleController.removeListener(_validate);
        descriptionController.removeListener(_validate);
      };
    });

    useEffect(() {
      isListingTypeEnabled.value =
          selectedCategory.value.isNotEmpty &&
          (selectedCategory.value == 'Ambulance equipment' ||
              selectedCategory.value == 'Medical transport');

      return null;
    });
    useEffect(() {
      notEnabledListTypeHintText.value = selectedCategory.value.isNotEmpty
          ? 'Not applicable for this category'
          : 'Choose a category first';
      return null;
    });

    useEffect(() {
      isStockEnabled.value = selectedListType.value == 'Sale';
      return null;
    });

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
        orElse: () => categories.first,
      );
      return match.departments.map((e) => e.name).toList();
    }

    return Card(
      color: AppColours.white,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropDownFormFieldBuilder(
                    value: selectedCategory.value,
                    isEnabled: true,
                    title: 'Service category',
                    hintText: 'Select a category',
                    items: categoryNames,
                    placeHolder: 'Select a category',
                    onChanged: (value) {
                      if (value != null) {
                        selectedDept.value = '';
                        selectedListType.value = '';
                        stockController.text = '';
                        selectedCategory.value = value;
                      } else {
                        selectedCategory.value = '';
                      }
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
                      selectedDept.value = value!;
                    },
                    title: 'Department (sub-category)',
                    placeHolder: 'Select a department',
                  ),
                  SizedBox(height: 15.h),
                  DropDownFormFieldBuilder(
                    value: selectedListType.value,
                    hintText: 'Select a listing type',
                    isEnabled: isListingTypeEnabled.value,
                    notEnabledhintText: notEnabledListTypeHintText.value,
                    items: listType,
                    onChanged: (value) {
                      selectedListType.value = value!;
                    },
                    title: 'Listing type',
                    placeHolder: 'Select a listing type',
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Stock',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    enabled: isStockEnabled.value,
                    controller: stockController,
                    validator: isStockEnabled.value
                        ? FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ])
                        : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: isStockEnabled.value
                          ? 'Enter stock quantity'
                          : 'Available only for sale listings',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Price (NGN)',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    enabled: isStockEnabled.value,
                    controller: priceController,
                    validator: isStockEnabled.value
                        ? FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ])
                        : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: isStockEnabled.value
                          ? 'Enter price in naira'
                          : 'Available only for sale listings',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                  TextFormField(
                    controller: titleController,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'e.g. Event medical standby - 2 ambulances',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          'Coverage area, crew size, vehicle types, pricing notes...',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            PhotoSection(
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
                  return SizedBox.shrink();
                }
                return ErrorMessageContainer(errorMessage: errorMessage);
              },
            ),
            BlocListener<AddServiceBloc, AddServiceState>(
              listener: (context, state) {
                if (state is AddServiceSuccess) {
                  BlocProvider.of<GetServicesBloc>(context).add(GetServices());
                  BlocProvider.of<AddServiceBloc>(
                    context,
                  ).add(AddServiceReset());
                  isResetting.value = true;
                  _formKey.currentState?.reset();
                  titleController.clear();
                  descriptionController.clear();
                  priceController.clear();
                  stockController.clear();
                  selectedCategory.value = '';
                  selectedDept.value = '';
                  selectedListType.value = '';
                  selectedImages.value = [];
                  filePaths.value = [];
                  isFormValid.value = false;
                  isListingTypeEnabled.value = false;
                  isStockEnabled.value = false;
                  BlocProvider.of<NavigationCubit>(context).setPage(2);
                }
              },
              child: BlocSelector<AddServiceBloc, AddServiceState, bool>(
                selector: (state) => state is AddServiceLoading ? true : false,
                builder: (context, isLoading) {
                  return SubmitButton(
                    buttonText: isLoading
                        ? 'Publishing service'
                        : 'Publish service',
                    textStyle: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColours.white),
                    onPressed: isFormValid.value && !isLoading
                        ? () {
                            BlocProvider.of<AddServiceBloc>(context).add(
                              AddService(
                                service: ServiceParams(
                                  dept: categories
                                      .firstWhere(
                                        (e) => e.name == selectedCategory.value,
                                      )
                                      .departments
                                      .firstWhere(
                                        (e) => e.name == selectedDept.value,
                                      )
                                      .slug,
                                  description: descriptionController.text
                                      .trim(),
                                  photoUrls: selectedImages.value,
                                  serviceCategory: categories
                                      .firstWhere(
                                        (e) => e.name == selectedCategory.value,
                                      )
                                      .slug,
                                  title: titleController.text.trim(),
                                  stock: isStockEnabled.value
                                      ? int.parse(stockController.text.trim())
                                      : null,
                                  price: isStockEnabled.value
                                      ? int.parse(priceController.text.trim())
                                      : null,
                                  listingType: selectedListType.value.isEmpty
                                      ? null
                                      : selectedListType.value,
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
