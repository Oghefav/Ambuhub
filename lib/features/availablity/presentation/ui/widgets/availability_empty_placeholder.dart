import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_event.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailabilityEmptyPlaceholder extends StatelessWidget {
  const AvailabilityEmptyPlaceholder({super.key});

  void _openAddService(BuildContext context) {
    context.read<NavigationCubit>().setPage('addService');
    context.read<AddServiceBloc>().add(const AddServiceReset());
    Navigator.pushReplacementNamed(context, AppRoutes.addServiceScreen);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 11.sp,
      color: AppColours.grey,
      height: 1.35,
    );
    final linkStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 11.sp,
      color: AppColours.vividTeal,
      fontWeight: FontWeight.w600,
    );

    return DottedBorderContainer(
      child: SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: bodyStyle,
                children: [
                  const TextSpan(text: 'No listings yet. '),
                  TextSpan(
                    text: 'Add service',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _openAddService(context),
                  ),
                  const TextSpan(text: ' first.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
