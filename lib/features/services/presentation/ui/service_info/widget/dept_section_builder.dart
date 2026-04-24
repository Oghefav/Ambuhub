import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeptSectionBuilder extends StatelessWidget {
  final String deptName;
  final List<ServiceEntity> services;
  const DeptSectionBuilder({
    super.key,
    required this.deptName,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    final int  servicesLength = services.length;
    return SliverPadding(
      padding: EdgeInsets.only(left: 15.w),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Text(deptName, style: Theme.of(context).textTheme.titleSmall),
          ),
          if (servicesLength > 1)
          SliverToBoxAdapter(
            child: SizedBox(
              // width: 300.w,
              height: 300.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: servicesLength,
                 itemBuilder:  (context, index) {
                 return SizedBox(
                  width: 300.w,
                   child: _serviceItemBuilder(context, services[index]),
                 );
                }, 
                
              ),
            ),
          ),
          if(servicesLength == 1)
          SliverToBoxAdapter(child: _serviceItemBuilder(context, services[0],)),
        ],
      ),
    );
  }
}

Widget _serviceItemBuilder(BuildContext context, ServiceEntity service,)  {
  return Card(
                    margin: EdgeInsets.only(bottom: 20.h, right: 15.w),
                      color: AppColours.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        
                        side: BorderSide(color: AppColours.veryLightVividTeal),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 8,
                            child: ClipRRect(
                               borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: service.photoUrls[0],
                                fadeInDuration: Duration.zero,
                                fadeOutDuration: Duration.zero,
                                progressIndicatorBuilder: (context, url, progress) =>
                                    const CupertinoActivityIndicator(
                                      color: AppColours.blue,
                                    ),
                                errorWidget: (context, url, error) =>
                                    const SizedBox.shrink(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.title,
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                      SizedBox(height: 15.h),
                                      Text(
                                        service.description,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                              ),
                              
                            
                          
                        ],
                      ),
                    );
}