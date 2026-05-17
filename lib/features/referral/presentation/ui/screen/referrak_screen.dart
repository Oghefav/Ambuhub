import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:flutter/material.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientAppScaffold(
      body: EmptyContentPageBuilder(
        heading: 'Referrals',
        description: 'Invite employers and organizers to Ambuhub.',
        placeholderText: 'Referral program placeholder.',
      ),
    );
  }
}
