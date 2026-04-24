import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/onboarding/widgets/onboarding_page_builder.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GetServiceCatBloc, GetServiceCatState>(
          builder: (context, state) {
            if (state is GetServiceCatSuccess) {
              final serviceCategories = state.categories;
              return Padding(
                padding: EdgeInsets.all(15.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 610.h,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          currentPage.value = index;
                        },
                        controller: pageController,
                        itemCount: serviceCategories!.length,
                        itemBuilder: (context, index) {
                          return OnboardingPageBuilder(
                            category: serviceCategories[index],
                          );
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: serviceCategories.length,
                      effect: const JumpingDotEffect(
                        activeDotColor: AppColours.blue,
                        dotColor: AppColours.grey,
                      ),
                    ),
                    SubmitButton(
                      buttonText:
                          currentPage.value == serviceCategories.length - 1
                          ? 'Get started'
                          : 'Next',
                      onPressed: () {
                        if (currentPage.value == serviceCategories.length - 1) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.loginScreen,
                          );
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is GetServiceCatLoading) {
              return ColoredBox(
                color: AppColours.white,
                child: CircularProgressIndicator(),
              );
            }
            return ColoredBox(color: AppColours.blue, child: SizedBox.shrink());
          },
        ),
      ),
    );
  }
}
