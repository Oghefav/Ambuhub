import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_bloc.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_event.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_state.dart';
import 'package:ambuhub/features/provider_notifications/presentation/ui/widgets/provider_notifications_empty_state.dart';
import 'package:ambuhub/features/provider_notifications/presentation/ui/widgets/provider_notifications_header.dart';
import 'package:ambuhub/features/provider_notifications/presentation/ui/widgets/provider_notifications_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderNotificationsScreen extends HookWidget {
  const ProviderNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final bloc = context.read<ProviderNotificationsBloc>();
      bloc
        ..add(const GetProviderNotifications())
        ..add(const GetProviderUnreadNotificationCount());
      return null;
    }, const []);

    return ProviderAppScaffold(
      body: BlocBuilder<ProviderNotificationsBloc, ProviderNotificationsState>(
        builder: (context, state) {
          final notifications = state.notifications;
          final isEmpty = state.hasLoaded &&
              !state.isLoadingList &&
              notifications.isEmpty;

          return CustomScrollView(
            slivers: [
              const CustomAppbar(),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 24.h),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProviderNotificationsHeader(),
                      SizedBox(height: 15.h),
                      if (state.errorMessage != null &&
                          state.errorMessage!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: ErrorMessageContainer(
                            errorMessage: state.errorMessage!,
                          ),
                        ),
                      if (state.isLoadingList && !state.hasLoaded)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: const Center(
                            child: CupertinoActivityIndicator(
                              color: AppColours.blue,
                            ),
                          ),
                        ),
                      if (isEmpty) const ProviderNotificationsEmptyState(),
                      if (!isEmpty && notifications.isNotEmpty)
                        ProviderNotificationsList(
                          notifications: notifications,
                          isMarkingAllRead: state.isMarkingRead,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
