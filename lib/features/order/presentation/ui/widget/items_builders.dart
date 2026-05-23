import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/order/core/util/order_line_format.dart';
import 'package:ambuhub/features/order/domain/entities/order_line_entity.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemsBuilders extends StatelessWidget {
  final List<OrderLineEntity> items;

  static const LinearGradient _priceGradient = LinearGradient(
    colors: [AppColours.vividTeal, AppColours.hireCyanBright],
  );

  const ItemsBuilders({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Text(
          'ITEMS',
          style: textTheme.bodySmall!.copyWith(color: AppColours.hireCyanDeep),
        ),
        ...items.map((item) => _buildItem(context, item)),
      ],
    );
  }

  Widget _buildItem(BuildContext context, OrderLineEntity item) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(13.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColours.hireCyanIce, width: 1.w),
        borderRadius: BorderRadius.circular(15.r),
        color: AppColours.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5.h,
        children: [
          Row(
            spacing: 10.w,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColours.hireCyanIce,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13.r),
                  child: _lineImage(item),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5.h,
                children: [
                     SizedBox(
                      width: 170.w,
                       child: Text(
                        maxLines: 2,
                          item.title.toTitleCase(),
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall?.copyWith(
                          fontSize: 12.sp),
                        ),
                     ),
                  SizedBox(
                    width: 170.w,
                    child: Text(

                      '${item.categoryName} · ${item.departmentName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall!.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(
            formatOrderLineQuantityDetail(item),
            style: textTheme.bodySmall!.copyWith(fontSize: 12.sp),
          ),
          item.hireStart != null ? Text(
            '${formatDateTimeShort(item.hireStart)} → ${formatDateTimeShort(item.hireEnd)}',
            style: textTheme.bodySmall!.copyWith(fontSize: 12.sp),
          ) : const SizedBox.shrink(),
          
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => _priceGradient.createShader(bounds),
            child: Text(
              formatCurrency(item.lineTotalNgn),
              style: textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
             context.read<NavigationCubit>().setPage('reviews');
             Navigator.pushReplacementNamed(context, AppRoutes.reviewsScreen);
            },
            child: Text('Leave a review', style: textTheme.titleSmall!.copyWith(
              color: AppColours.darkVividTeal,
              fontSize: 12.sp),),
          )
        ],
      ),
    );
  }

  Widget _lineImage(OrderLineEntity item) {
    final url = item.primaryImageUrl;
    final size = Size(72.w, 72.h);
    if (url == null) {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: const Icon(Icons.image_not_supported_outlined),
      );
    }
    return SizedBox(
      width: size.width,
      height: size.height,
      child: CachedNetworkImage(
        imageUrl: url,
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (_, __, ___) =>
            const Center(child: CupertinoActivityIndicator()),
        errorWidget: (_, __, ___) =>
            const Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
