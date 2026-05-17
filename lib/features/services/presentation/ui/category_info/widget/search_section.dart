import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/presentation/ui/category_info/widget/search_drop_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> depts;
  final List<String> listingTypes;
  final Function(String?) onChangeDept;
  final Function() onReset;
  final Function(String?) onChangeListingType;
  const SearchSection({super.key,required this.listingTypes, required this.searchController, required this.depts, required this.onChangeDept, required this.onChangeListingType, required this.onReset});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(10.h),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColours.veryLightBlue,
            AppColours.vividTeal,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColours.veryLightVividTeal, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Search & filters', style: textTheme.titleSmall!.copyWith(color: AppColours.white)),
            TextButton(
                onPressed: onReset,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    decorationColor: AppColours.veryLightGrey,
                    decoration: TextDecoration.underline, color: AppColours.veryLightGrey),
                ),
              )
          ],
        ),
        SizedBox(height: 10.h),
        Text(
            'Search Listings',
            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500, color: AppColours.white),
          ),
        TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search title, description, listing type, price, etc.',
            hintStyle: textTheme.bodyMedium!.copyWith(color: AppColours.white,),
            prefixIcon: Icon(LucideIcons.search, color: AppColours.white, size: 15.sp),
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
