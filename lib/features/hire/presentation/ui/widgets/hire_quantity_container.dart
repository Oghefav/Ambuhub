import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireQuantityContainer extends StatelessWidget {
  final ServiceEntity service;
  final ValueNotifier<int> quantity;

  const HireQuantityContainer({
    super.key,
    required this.service,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: quantity,
      builder: (context, qty, _) => _buildContent(context, qty),
    );
  }

  Widget _buildContent(BuildContext context, int qty) {
    final textTheme = Theme.of(context).textTheme;
    final maxStock = service.stock ?? 0;

    return ShadowedContainer(
      shadowColor: AppColours.hireVioletBright.withAlpha(50),
      borderColor: AppColours.hireVioletBright.withAlpha(100),
      topGradientColors: [
        AppColours.hireVioletBright,
        AppColours.hireMagenta,
        AppColours.hireVioletBright.withAlpha(50),
      ],
      bodyGradientColors: [
        Color.lerp(AppColours.hireVioletBright, Colors.white, 0.8)!,
        AppColours.white,
        // AppColours.white
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,

      topStops: const [0.0, 0.5, 1.0],
      bodyStops: const [0.0, 1.0],
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            Row(
              spacing: 10.w,
              children: [
                IconGradientContainer(
                  icon: LucideIcons.hash,
                  gradientStops: const [0.0, 1.0],
                  colors: const [
                    AppColours.hireVioletBright,
                    AppColours.hireMagenta,
                  ],
                  size: 13.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QUANTITY',
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 11.sp,
                        color: AppColours.hirePurpleDeep,
                      ),
                    ),
                    Text(
                      'How many units to hire',
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                        color: AppColours.hireVioletBright.withAlpha(100),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  width: 1.5.w,
                  color: AppColours.hireVioletBright.withAlpha(100),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10.w,
                children: [
                  GestureDetector(
                    onTap: qty > 1 ? () => quantity.value-- : null,
                    child: Icon(
                      Icons.remove,
                      size: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: qty <= 1
                          ? AppColours.veryLightGrey
                          : AppColours.hireVioletBright,
                    ),
                  ),
                  Text('$qty'),
                  GestureDetector(
                    onTap: qty < maxStock ? () => quantity.value++ : null,
                    child: Icon(
                      Icons.add,
                      size: 15.sp,
                      color: qty >= maxStock
                          ? AppColours.veryLightGrey
                          : AppColours.hireVioletBright,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      
    );
  }
}
