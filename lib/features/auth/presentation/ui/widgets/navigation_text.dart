import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavigationText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String routeName;
  const NavigationText({super.key, required this.firstText, required this.secondText, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(
              text: secondText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColours.blue,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () =>
                    Navigator.pushNamed(context, routeName),
            ),
          ],
        ),
      ),
    );
  }
}
