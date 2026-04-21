import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/widgets/onboarding_page_builder.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetServiceCatBloc, GetServiceCatState>(
      builder: (context, state) {
        if (state is GetServiceCatSuccess) {
          final serviceCategories = state.categories;
          return Column(
            children: [
              PageView.builder(
                itemCount: serviceCategories!.length,
                itemBuilder: (context, index) {
                  return OnboardingPageBuilder(
                    category: serviceCategories[index],
                  );
                },
              ),
            ],
          );
        }
        if (state is GetServiceCatLoading) {
          return ColoredBox(
            color: AppColours.white,
            child: CircularProgressIndicator(),
          );
        }
        return ColoredBox(
          color: AppColours.blue,
          child: SizedBox.shrink());
      },
    );
  }
}
