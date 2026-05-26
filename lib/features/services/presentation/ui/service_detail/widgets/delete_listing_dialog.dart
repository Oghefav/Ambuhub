import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteListingDialog extends StatelessWidget {
  final ServiceEntity service;

  const DeleteListingDialog({super.key, required this.service});

  static Future<void> show(BuildContext context, ServiceEntity service) {
    final deleteBloc = context.read<DeleteServiceBloc>();
    deleteBloc.add(const DeleteServiceReset());
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: deleteBloc,
        child: DeleteListingDialog(service: service),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final listingTitle = service.title.toTitleCase();

    return Dialog(
      backgroundColor: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: BlocBuilder<DeleteServiceBloc, DeleteServiceState>(
          builder: (context, state) {
            final isLoading = state is DeleteServiceLoading;
            final errorMessage = state is DeleteServiceError
                ? state.errorMessage
                : null;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Delete this listing?',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColours.darkGrey,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'This removes "$listingTitle" from the marketplace. You cannot undo this action.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColours.grey,
                    height: 1.4,
                  ),
                ),
                if (errorMessage != null && errorMessage.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  ErrorMessageContainer(errorMessage: errorMessage),
                ],
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _DialogButton(
                      label: 'Cancel',
                      onPressed: isLoading
                          ? null
                          : () => Navigator.of(context).pop(),
                      isOutlined: true,
                    ),
                    SizedBox(width: 10.w),
                    _DialogButton(
                      label: isLoading ? 'Deleting...' : 'Delete listing',
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<DeleteServiceBloc>().add(
                                    DeleteService(service.id),
                                  );
                            },
                      isDestructive: true,
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isDestructive;
  final bool isLoading;

  const _DialogButton({
    required this.label,
    this.onPressed,
    this.isOutlined = false,
    this.isDestructive = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final verticalPadding = isDestructive ? 11.h : 9.h;

    return Material(
      color: isOutlined
          ? Colors.transparent
          : (isDestructive ? AppColours.deepRed : AppColours.vividTeal),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: isOutlined
                ? Border.all(color: AppColours.veryLightGrey)
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: verticalPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 14.w,
                    height: 14.w,
                    child: CupertinoActivityIndicator(
                      radius: 7.r,
                      color: AppColours.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
                Text(
                  label,
                  style: textTheme.titleSmall?.copyWith(
                    color: isOutlined ? AppColours.darkGrey : AppColours.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
