import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsViewOrdersFooter extends StatelessWidget {
  const ReviewsViewOrdersFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyStyle = textTheme.bodySmall;

    return RichText(
      text: TextSpan(
        style: bodyStyle,
        children: [
          TextSpan(
            text: 'View orders',
            style: bodyStyle?.copyWith(
              color: AppColours.vividTeal,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: AppColours.vividTeal,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.read<NavigationCubit>().setPage('order');
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.orderScreen,
                );
              },
          ),
          const TextSpan(
            text: ' for receipts and purchase history.',
          ),
        ],
      ),
    );
  }
}
