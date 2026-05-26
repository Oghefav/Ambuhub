import 'dart:async';

import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  /// When set (bootstrap launch), called after the animation finishes instead
  /// of navigating to onboarding.
  final VoidCallback? onAnimationComplete;

  const SplashScreen({super.key, this.onAnimationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _topGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColours.penBlue, Color(0xFF0143B1), Color(0xFF0244AD)],
    stops: [0.0, 0.55, 1.0],
  );

  static const _animDuration = Duration(milliseconds: 2800);
  static const _holdAfterAnim = Duration(milliseconds: 800);

  late final AnimationController _controller;

  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _heroFade;
  late final Animation<Offset> _heroSlide;
  late final Animation<double> _footerFade;
  late final Animation<Offset> _footerSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animDuration);
    _buildAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_startSplash());
    });
  }

  Future<void> _startSplash() async {
    // Paint one frame with content hidden, then start after native splash hands off.
    await SchedulerBinding.instance.endOfFrame;
    if (!mounted) return;
    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (!mounted) return;

    unawaited(_precacheOnboardingImages());

    _controller.reset();
    await _controller.forward();
    if (!mounted) return;

    await Future<void>.delayed(_holdAfterAnim);
    if (!mounted) return;

    final onComplete = widget.onAnimationComplete;
    if (onComplete != null) {
      onComplete();
      return;
    }

    Navigator.of(context).pushReplacement(AppRoutes.onboardingRoute());
  }

  void _buildAnimations() {
    Animation<double> fade(double begin, double end, Curve curve) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(begin, end, curve: curve),
        ),
      );
    }

    Animation<Offset> slide(
      double begin,
      double end,
      Offset from, {
      Curve curve = Curves.easeOutCubic,
    }) {
      return Tween<Offset>(begin: from, end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(begin, end, curve: curve),
        ),
      );
    }

    _logoFade = fade(0, 0.35, Curves.easeOut);
    _logoScale = Tween<double>(begin: 0.75, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.4, curve: Curves.easeOutBack),
      ),
    );
    _logoSlide = slide(0, 0.35, const Offset(0, -0.15));
    _titleFade = fade(0.15, 0.45, Curves.easeOut);
    _titleSlide = slide(0.15, 0.45, const Offset(0, 0.12));
    _taglineFade = fade(0.25, 0.55, Curves.easeOut);
    _taglineSlide = slide(0.25, 0.55, const Offset(0, 0.08));
    _heroFade = fade(0.35, 0.75, Curves.easeOut);
    _heroSlide = slide(0.35, 0.75, const Offset(0, 0.18));
    _footerFade = fade(0.55, 1, Curves.easeOut);
    _footerSlide = slide(0.55, 1, const Offset(0, 0.06));
  }

  Future<void> _precacheOnboardingImages() async {
    try {
      await Future.wait<void>([
        precacheImage(
          const AssetImage('assets/images/onboarding1.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/images/onboarding2.png'),
          context,
        ),
        precacheImage(
          const AssetImage('assets/images/onboarding3.png'),
          context,
        ),
      ]);
    } catch (_) {
      // Non-fatal; onboarding still loads images on demand.
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _fadeSlide({
    required Animation<double> fade,
    required Animation<Offset> slide,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0244AD),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(gradient: _topGradient),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _logoScale,
                          child: _fadeSlide(
                            fade: _logoFade,
                            slide: _logoSlide,
                            child: Image.asset(
                              'assets/images/splash.png',
                              height: 140.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _fadeSlide(
                          fade: _titleFade,
                          slide: _titleSlide,
                          child: Text(
                            'AmbuHub',
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(
                                  color: AppColours.white,
                                  fontSize: 35.sp,
                                ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _fadeSlide(
                          fade: _taglineFade,
                          slide: _taglineSlide,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Text(
                              'Care. Connect. Delivered',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: AppColours.veryLightGrey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _fadeSlide(
                fade: _heroFade,
                slide: _heroSlide,
                child: Image.asset(
                  'assets/images/splash2.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              _fadeSlide(
                fade: _footerFade,
                slide: _footerSlide,
                child: Container(
                  width: double.infinity,
                  color: AppColours.splashBackgroundBlue,
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                  child: Column(
                    children: [
                      Text(
                        'Your trusted marketplace for',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColours.veryLightGrey,
                        ),
                      ),
                      Text(
                        'medical services and equipment.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColours.veryLightGrey,
                        ),
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
