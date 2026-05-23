import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_text_gradient_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/utils.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireServiceDetailsTopSection extends StatelessWidget {
  final ServiceEntity service;
 final String billingPeriod;
  const HireServiceDetailsTopSection({super.key, required this.service, required this.billingPeriod});

  

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final availableStock = service.stock ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10.w,
          children: [
            IconGradientContainer(
              gradientStops: const [0.0, 1.0],
              icon: LucideIcons.package,
              colors: const [
                AppColours.hireCyanBright,
                AppColours.hireCyanDeep,
              ],
              size: 15.sp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SERVICE DETAILS',
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColours.darkBrandBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Review the listing before you book',
                  style: textTheme.bodySmall!.copyWith(
                    color: AppColours.hireCyanBright,
                    fontSize: 10.sp
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          height: 100.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColours.hireCyanGlow),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: service.photoUrls.first,
              fit: BoxFit.fitWidth,
              progressIndicatorBuilder: (context, url, progress) =>const Center(
                child: CupertinoActivityIndicator(),
              ),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          service.title.toTitleCase(),
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 11.sp),
        ),
        SizedBox(height: 5.h),
        Text(
          '${service.serviceCategory} · ${service.dept}',
          style: textTheme.bodySmall!.copyWith(fontSize: 9.sp),
        ),
        SizedBox(height: 5.h),
        Text(
          service.description,
          style: textTheme.bodySmall!.copyWith(fontSize: 9.sp),
        ),
        SizedBox(height: 10.h),
        Row(
          spacing: 5.w,
          children: [
           HireTextGradientContainer(
          text1: formatCurrency(service.price),
          text2: ' per ${hireEffectivePricePeriod(service.pricePeriod)}',
          textColor: AppColours.white,
        ),
        HireTextGradientContainer(
          text1: '${billingPeriod.toTitleCase()} billing',
          color: AppColours.hireMintFoam,
          textColor: AppColours.hireForest,
        ),
        ],),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Stock available: ', style: textTheme.bodySmall!.copyWith(fontSize: 10.sp)),
              TextSpan(
                text: availableStock.toString(),
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  color: AppColours.darkBrandBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
