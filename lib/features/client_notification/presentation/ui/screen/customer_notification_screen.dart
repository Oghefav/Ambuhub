import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/features/client_notification/presentation/ui/widget/notifications_empty_state.dart';
import 'package:ambuhub/features/client_notification/presentation/ui/widget/notifications_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerNotificationScreen extends StatelessWidget {
  const CustomerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientAppScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 25.h,
          children: const [
            NotificationsHeader(),
            NotificationsEmptyState(),
          ],
        ),
      ),
    );
  }
}
