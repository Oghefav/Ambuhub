import 'dart:io';
import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_state.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/drop_down_form_field_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/photo_section.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/submit_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class UpdateServiceFormCard extends HookWidget {
  final ServiceEntity service;
  UpdateServiceFormCard({super.key, required this.service});

  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final List<String> listType = ['Sale', 'Rent'];

  @override
  Widget build(BuildContext context) {
    final categoriesData = context.read<GetServiceCatBloc>().state.categories;
    final categories = categoriesData?.map((e) => e).toList() ?? [];
    final categoryNames = categoriesData?.map((e) => e.name).toList() ?? [];
    final selectedCategory = useState<String>(service.serviceCategory);
    final selectedDept = useState<String>(service.dept);
    final titleController = useTextEditingController(text: service.title);
    final stockController = useTextEditingController(
      text: service.stock?.toString(),
    );
    final priceController = useTextEditingController(
      text: service.price?.toString(),
    );
    final descriptionController = useTextEditingController(
      text: service.description,
    );
    final filePaths = useState<List<String>>(service.photoUrls);
    final selectedImages = useState<List<File>?>(null);
    final isFormValid = useState<bool>(false);
    final isListingTypeEnabled = useState<bool>(service.listingType != null);
    final isStockEnabled = useState<bool>(service.stock != null);
    final selectedListType = useState<String>(service.listingType ?? '');
    final notEnabledListTypeHintText = useState<String>(
      'Choose a category first',
    );
    final uploadedPhotoUrls = service.photoUrls;
    useEffect(() {
      Future.microtask(() {
        isFormValid.value = _formKey.currentState?.validate() ?? false;
      });
      return null;
    }, []);

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
                    initialValue: service.serviceCategory,
                    value: selectedCategory.value,
                    isEnabled: true,
                    title: 'Service category',
                    hintText: 'Select a category',
                    items: categoryNames,
                    placeHolder: 'Select a category',
                    onChanged: (value) {
                      if (value == selectedCategory.value) return;
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
                    initialValue: service.dept,
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
                    initialValue: service.listingType,
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
              selectedImages: selectedImages.value ?? [],
              filePaths: filePaths.value,
              hintText:
                  '${uploadedPhotoUrls.length} image(s) on this listing. Add more below; new images are appended.',
              onTap: () async => await pickFile(),
            ),
            SizedBox(height: 15.h),
            BlocSelector<UpdateServiceBloc, UpdateServiceState, String?>(
              selector: (state) =>
                  state is UpdateServiceError ? state.errorMessage : null,
              builder: (context, errorMessage) {
                if (errorMessage == null) {
                  return SizedBox.shrink();
                }
                return ErrorMessageContainer(errorMessage: errorMessage);
              },
            ),
            BlocListener<UpdateServiceBloc, UpdateServiceState>(
              listener: (context, state) {
                if (state is UpdateServiceSuccess) {
                  BlocProvider.of<GetServicesBloc>(context).add(GetServices());
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.listingsScreen,
                  );
                }
              },
              child: BlocSelector<UpdateServiceBloc, UpdateServiceState, bool>(
                selector: (state) =>
                    state is UpdateServiceLoading ? true : false,
                builder: (context, isLoading) {
                  return ServiceSubmitButton(
                    buttonText: isLoading
                        ? 'Updating service'
                        : 'Update service',
                    onPressed: isFormValid.value && !isLoading
                        ? () {
                            BlocProvider.of<UpdateServiceBloc>(context).add(
                              UpdateService(
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
                                  photoUrls: selectedImages.value ?? [],
                                  serviceCategory: categories
                                      .firstWhere(
                                        (e) => e.name == selectedCategory.value,
                                      )
                                      .slug,
                                  uploadedPhotoUrls: uploadedPhotoUrls,
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
                                  id: service.id,
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
