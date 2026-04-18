import 'dart:io';
import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_state.dart';
import 'package:ambuhub/features/services/presentation/ui/screens/widget/drop_down_form_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class AddServiceFormCard extends HookWidget {
  AddServiceFormCard({super.key});

  final List<String> categories = [
    'Ambulance personnel',
    'Ambulance servicing',
    'Medical transport',
  ];
  final List<String> ambulancePersonnelDepts = [
    'Ambulance Driver',
    'Basic Emergency Medical Technician',
    'Paramedic(Air/Ground Ambulance)',
    'Ambulance Nurse',
    'Ambulance Doctor',
    'Emergency Physician',
    'Intensivist',
  ];

  final List<String> ambulanceServicingDepts = [
    'Ambulance Sales',
    'Ambulance Maintenance',
    'Ambulance equipment',
  ];

  final List<String> medicalTransportDepts = [
    'Ground Ambulance',
    'Air Ambulance',
    'Cargo for remains (Local and international)',
    'Hearse for remains',
    'Community Provider',
  ];

  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState<String>('');
    final selectedDept = useState<String>('');
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final filePaths = useState<List<String>>([]);
    final selectedImages = useState<List<File>>([]);
    final isFormValid = useState<bool>(false);

    void _validate() {
      // if ((titleController.text.isEmpty && descriptionController.text.isEmpty) ||  titleController.text.isEmpty ||
      //     descriptionController.text.isEmpty) {
      //   return;
      // }
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

    Future<void> pickFile() async {
      final List<XFile?> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.value = images.map((e) => File(e!.path)).toList();
        filePaths.value = images.map((e) => p.basename(e!.path)).toList();
      }
    }

    List<String> getDepartments() {
      switch (selectedCategory.value) {
        case 'Ambulance personnel':
          return ambulancePersonnelDepts;
        case 'Ambulance servicing':
          return ambulanceServicingDepts;
        default:
          return medicalTransportDepts;
      }
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
                    items: categories,
                    placeHolder: 'Select a category',
                    onChanged: (value) {
                      if (value != null) {
                        selectedDept.value = '';
                        selectedCategory.value = value;
                      } else {
                        selectedCategory.value = '';
                      }
                      // _validate();
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
                      // _validate();
                    },
                    title: 'Department (sub-category)',
                    placeHolder: 'Select a department',
                  ),
                  SizedBox(height: 15.h),
                  Text('Title', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 5.h),
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
                    style: Theme.of(context).textTheme.titleMedium,
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
            SizedBox(height: 15.h),
            Text('Photos', style: Theme.of(context).textTheme.titleSmall),
            Text(
              'Images only (JPEG, PNG, WebP, etc.). Up to 10 files, 5MB each.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    pickFile();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColours.blue,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      'Choose files',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: AppColours.white),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                if (selectedImages.value.isNotEmpty &&
                    selectedImages.value.length == 1)
                  Text(filePaths.value.first, overflow: TextOverflow.ellipsis),
                if (selectedImages.value.length > 1)
                  Text('${selectedImages.value.length} files.'),
              ],
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
                  BlocProvider.of<NavigationCubit>(context).setPage(2);
                }
              },
              child: BlocSelector<AddServiceBloc, AddServiceState, bool>(
                selector: (state) => state is AddServiceLoading ? true : false,
                builder: (context, isLoading) {
                  return SubmitButton(
                    buttonText: 'Publish service',
                    textStyle: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColours.white),
                    onPressed: isFormValid.value && !isLoading
                        ? () {
                            BlocProvider.of<AddServiceBloc>(context).add(
                              AddService(
                                service: ServiceParams(
                                  dept: selectedDept.value,
                                  description: descriptionController.text
                                      .trim(),
                                  photoUrls: selectedImages.value,
                                  serviceCategory: selectedCategory.value
                                      ,
                                  title: titleController.text.trim(),
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
