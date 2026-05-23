import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileActionSuccessMessage extends StatelessWidget {
  final String message;

  const ProfileActionSuccessMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 8.w,
      children: [
        Icon(
          LucideIcons.circle_check,
          color: AppColours.sageGreen,
          size: 18.sp,
        ),
        Text(
          message,
          style: textTheme.bodySmall?.copyWith(
            color: AppColours.sageGreen,
          ),
        ),
      ],
    );
  }
}

class ProfileActionFeedback extends StatelessWidget {
  final String? errorMessage;
  final bool showSuccess;
  final String successMessage;

  const ProfileActionFeedback({
    super.key,
    required this.errorMessage,
    required this.showSuccess,
    required this.successMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (showSuccess) {
      return ProfileActionSuccessMessage(message: successMessage);
    }

    if (errorMessage == null) {
      return const SizedBox.shrink();
    }

    return ErrorMessageContainer(errorMessage: errorMessage!);
  }
}
