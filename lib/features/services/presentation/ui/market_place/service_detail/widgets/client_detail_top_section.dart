import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDetailTopSection extends StatelessWidget {
  final ServiceEntity service;

  static const Color _borderColor = AppColours.hireCyanIce;

  const ClientDetailTopSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lightFill = Color.lerp(_borderColor, AppColours.white, 0.92)!;
    final shadowColor = Color.lerp(_borderColor, AppColours.white, 0.45)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 12.h,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10.w,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: lightFill,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: _borderColor),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 8.r,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 5.w,
                children: [
                  Icon(
                    LucideIcons.sparkles,
                    color: _borderColor,
                    size: 15.sp,
                  ),
                  Text(
                    'LISTING DETAILS',
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColours.darkVividTeal,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
        Text(
            '${service.serviceCategory.toTitleCase()} · ${service.dept}',
            style: textTheme.bodySmall?.copyWith(fontSize: 10.sp),
          
        ),
        _ServicePhotoGallery(photoUrls: service.photoUrls),
      ],
    );
  }
}

class _ServicePhotoGallery extends StatelessWidget {
  final List<String> photoUrls;

  const _ServicePhotoGallery({required this.photoUrls});

  @override
  Widget build(BuildContext context) {
    if (photoUrls.isEmpty) {
      return _PhotoFrame(
        height: 200.h,
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined),
        ),
      );
    }

    final children = <Widget>[
      _PhotoFrame(
        height: 200.h,
        child: _NetworkPhoto(url: photoUrls.first),
      ),
    ];

    final rest = photoUrls.skip(1).toList();
    for (var i = 0; i < rest.length; i += 2) {
      children.add(
        Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: _PhotoFrame(
                height: 150.h,
                child: _NetworkPhoto(url: rest[i]),
              ),
            ),
            if (i + 1 < rest.length)
              Expanded(
                child: _PhotoFrame(
                  height: 150.h,
                  child: _NetworkPhoto(url: rest[i + 1]),
                ),
              )
            else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 8.h,
      children: children,
    );
  }
}

class _PhotoFrame extends StatelessWidget {
  final double height;
  final Widget child;

  const _PhotoFrame({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: ClientDetailTopSection._borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: child,
      ),
    );
  }
}

class _NetworkPhoto extends StatelessWidget {
  final String url;

  const _NetworkPhoto({required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (_, __, ___) =>
            const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
