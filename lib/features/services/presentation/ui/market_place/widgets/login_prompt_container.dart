import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPromptContainer extends StatelessWidget {
  const LoginPromptContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w).copyWith(top: 15.h),
      decoration: BoxDecoration(
        color: AppColours.frostBlue,
        border: Border.all(color: AppColours.veryLightVividTeal),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.h),
        child: Column(
          spacing: 15.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Purchasing & saving listings', style: textTheme.titleSmall),
            RichText(
              text: TextSpan(
                style: textTheme.bodySmall,
                children: [
                  const TextSpan(text: 'You need to '),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(context, AppRoutes.loginScreen),
                    text: 'log in',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColours.vividTeal,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColours.vividTeal,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ' before "Add to cart" or the heart (save to favorites) will work. Both ',
                  ),
                  TextSpan(
                    text: 'client',
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'service provider ',
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'accounts can buy sale items—the cart and badge only appear after you are signed in.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
