import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/presentation/ui/service_info/widget/search_drop_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> depts;
  final List<String> listingTypes;
  final Function(String?) onChangeDept;
  final Function(String?) onChangeListingType;
  const SearchSection({super.key,required this.listingTypes, required this.searchController, required this.depts, required this.onChangeDept, required this.onChangeListingType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColours.veryLightVividTeal, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
            'Search Listings',
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
          ),
        TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search title, description, listing type, price, etc.',
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColours.grey,),
            prefixIcon: Icon(LucideIcons.search, color: AppColours.grey, size: 15.sp),
          ),
        ),
        SizedBox(height: 10.h),
        SearchDropContainer( items: depts, onChanged: onChangeDept, title: 'Department',),
        SizedBox(height: 10.h),
        SearchDropContainer( items: listingTypes, onChanged: onChangeListingType, title: 'Listing Type',)
        ],
      ),
    );
  }
}
