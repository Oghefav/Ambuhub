import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/change_password_section.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/incomplete_profile_card.dart';
import 'package:ambuhub/features/provider_profile/presentation/ui/utils/provider_profile_utils.dart';
import 'package:ambuhub/features/provider_profile/presentation/ui/widget/provider_account_section.dart';
import 'package:ambuhub/features/provider_profile/presentation/ui/widget/provider_contact_info_card.dart';
import 'package:ambuhub/features/provider_profile/presentation/ui/widget/provider_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderProfileScreen extends HookWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lastKnownProvider = useRef<ServiceProviderEntity?>(null);

    return ProviderAppScaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess && state.data is ServiceProviderEntity) {
            lastKnownProvider.value = state.data as ServiceProviderEntity;
          }

          final provider = lastKnownProvider.value;
          final isProfileComplete =
              provider != null && isProviderProfileComplete(provider);

          return CustomScrollView(
            slivers: [
              const CustomAppbar(),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 24.h),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15.h,
                    children: [
                      const ProviderProfileHeader(),
                      if (provider == null)
                        const IncompleteProfileCard()
                      else ...[
                        ProviderContactInfoCard(provider: provider),
                        if (isProfileComplete) ...[
                          ProviderAccountSection(provider: provider),
                          ChangePasswordSection(),
                        ],
                      ],
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
