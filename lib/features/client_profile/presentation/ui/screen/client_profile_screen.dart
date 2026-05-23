import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/utils/client_profile_utils.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/account_type_widget.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/change_password_section.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/incomplete_profile_card.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/personal_info_card.dart';
import 'package:ambuhub/features/client_profile/presentation/ui/widget/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientProfileScreen extends HookWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lastKnownClient = useRef<ClientEntity?>(null);

    return ClientAppScaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess && state.data is ClientEntity) {
            lastKnownClient.value = state.data as ClientEntity;
          }

          final client = lastKnownClient.value;
          final isProfileComplete =
              client != null && isClientProfileComplete(client);

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.h,
              children: [
                const ProfileHeader(),
                if (client == null)
                  const IncompleteProfileCard()
                else ...[
                  PersonalInfoCard(client: client),
                  if (isProfileComplete) ...[
                    AccountTypeWidget(client: client),
                    ChangePasswordSection(),
                  ],
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
