import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/onboarding/widgets/onboarding_chip.dart';
import 'package:ambuhub/features/onboarding/presentation/ui/onboarding/widgets/onboarding_page_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class _OnboardingChipData {
  final IconData icon;
  final String label;

  const _OnboardingChipData({required this.icon, required this.label});
}

class _OnboardingPageData {
  final Widget title;
  final Widget description;
  final String image;
  final List<_OnboardingChipData> chips;

  const _OnboardingPageData({
    required this.title,
    required this.description,
    required this.image,
    required this.chips,
  });
}

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  static List<_OnboardingPageData> _pages(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.titleLarge?.color,
    );
    final accentStyle = titleStyle.copyWith(color: AppColours.primaryColor);
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;
    return [
    _OnboardingPageData(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('All Medical Services', style: titleStyle),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'in ',
                  style: titleStyle,
                ),
                TextSpan(
                  text: 'One Place',
                  style: accentStyle,
                ),
              ],
            ),
          ),
        ],
      ),
      image: 'assets/images/onboarding1.png',
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Book ambulance, medical', style: bodyStyle),
          Text('transport, hire professionals, or buy equipment', style: bodyStyle),
          Text(' — anytime, anywhere.', style: bodyStyle)
        ],
      ),
      chips: const [
        _OnboardingChipData(icon: LucideIcons.zap, label: 'Fast Booking'),
        _OnboardingChipData(
          icon: LucideIcons.shield_check,
          label: 'Verified Providers',
        ),
        _OnboardingChipData(icon: LucideIcons.shield, label: 'Secure Payments'),
      ],
    ),
    _OnboardingPageData(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Shop Equipment,', style: titleStyle),
          RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hire ',
              style: titleStyle,
            ),
            TextSpan(
              text: 'Experts',
                style: accentStyle,
              ),
            ],
          ),)
        ],
      ),
      description:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Find quality medical equpment and', style: bodyStyle),
              Text('hire certified doctors,', style: bodyStyle),
              Text('nurses, and paramedics.', style: bodyStyle)
            ],
          ),
      image: 'assets/images/onboarding2.png',
      chips: const [
        _OnboardingChipData(
          icon: LucideIcons.package_check,
          label: 'Quality Equipments',
        ),
        _OnboardingChipData(
          icon: LucideIcons.user_check,
          label: 'Trusted Professionals',
        ),
        _OnboardingChipData(icon: LucideIcons.tag, label: 'Great Prices'),
      ],
    ),
    _OnboardingPageData(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('For Clients', style: titleStyle),
          Text('and Service Providers', style: titleStyle),
          
            Text( 'Everyone Benefits',
              style: accentStyle,
            ),
      ],),
        description:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Whether you need a service or provide one,', style: bodyStyle),
          Text('AmbuHub connects you to more ', style: bodyStyle),  
          Text('oppurtunities and better care.', style: bodyStyle)
        ],
      ),
      image: 'assets/images/onboarding3.png',
      chips: const [
        _OnboardingChipData(icon: LucideIcons.globe, label: 'More Reach'),
        _OnboardingChipData(icon: LucideIcons.handshake, label: 'More Trust'),
        _OnboardingChipData(
          icon: LucideIcons.trending_up,
          label: 'More Impact',
        ),
      ],
    ),
  ];
  }

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);
    final pages = _pages(context);

    return Scaffold(
      backgroundColor: AppColours.verylightTeal,
      body: SafeArea(
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  GestureDetector(
                    onTap: () {
                      if (currentPage.value >= pages.length - 1) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.loginScreen,
                          (route) => false,
                        );
                        return;
                      }
                      pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColours.primaryColor,
                          ),
                    ),
                  ),
                  SizedBox(width: 25.w),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    currentPage.value = index;
                  },
                  controller: pageController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return OnboardingPageBuilder(
                      title: page.title,
                      description: page.description,
                      image: page.image,
                      firstChip: OnboardingChip(
                        icon: page.chips[0].icon,
                        label: page.chips[0].label,
                      ),
                      secondChip: OnboardingChip(
                        icon: page.chips[1].icon,
                        label: page.chips[1].label,
                      ),
                      thirdChip: OnboardingChip(
                        icon: page.chips[2].icon,
                        label: page.chips[2].label,
                      ),
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: SlideEffect(
                  activeDotColor: AppColours.primaryColor,
                  dotColor: AppColours.grey,
                  dotWidth: 25.w,
                  dotHeight: 5.h,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        
      ),
    );
  }
}
