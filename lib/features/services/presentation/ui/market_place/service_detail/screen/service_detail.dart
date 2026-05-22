import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/services/presentation/bloc/marketplace_service_detail/marketplace_service_detail_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/marketplace_service_detail/marketplace_service_detail_state.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/widgets/client_detail_actions_section.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/widgets/client_detail_top_section.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/widgets/service_detail_back_button.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/widgets/client_detial_description_section.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/widgets/client_detial_schedule_section.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/widgets/reviews_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketPlaceServiceDetailScreen extends StatelessWidget {
  final String backLabel;

  const MarketPlaceServiceDetailScreen({
    super.key,
    required this.backLabel,
  });

  double _contentTopPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).top + 52.h;
  }

  @override
  Widget build(BuildContext context) {
    final contentTop = _contentTopPadding(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const GradientBackground(),
          BlocBuilder<MarketplaceServiceDetailBloc,
              MarketplaceServiceDetailState>(
            builder: (context, state) {
              if (state is MarketplaceServiceDetailFailure) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    contentTop,
                    16.w,
                    16.h,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ErrorMessageContainer(
                      addBorder: true,
                      errorMessage: state.errorMessage,
                    ),
                  ),
                );
              }

              if (state is MarketplaceServiceDetailReady) {
                final service = state.service;
                return ListView(
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    contentTop,
                    16.w,
                    16.h,
                  ),
                  children: [
                    ClientDetailTopSection(service: service),
                    SizedBox(height: 16.h),
                    ClientDetailScheduleSection(service: service),
                    SizedBox(height: 16.h),
                    ClientDetailDescriptionSection(service: service),
                    SizedBox(height: 16.h),
                    ClientDetailActionsSection(service: service),
                    SizedBox(height: 16.h),
                    ReviewsSection(serviceReviews: state.serviceReviews),
                  ],
                );
              }

              return const Center(child: CupertinoActivityIndicator());
            },
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: ServiceDetailBackButton(backLabel: backLabel),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
