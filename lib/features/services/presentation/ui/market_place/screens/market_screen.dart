import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/widget/top_section.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_event.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:ambuhub/features/services/presentation/ui/category_info/widget/dept_section_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/category_info/widget/search_section.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/cart_summary_container.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/empty_service_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/category_filter_section.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/market_place_top_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketplaceScreen extends HookWidget {
  final ServiceCategoryEntity category;
  const MarketplaceScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<String> depts = category.departments
        .map((dept) => dept.name)
        .toList();
    final categories = context
        .read<GetServiceCategoriesBloc>()
        .state
        .serviceCategories;
    final cart = context.read<CartBloc>().state.cart;
    depts.insert(0, 'All Departments');
    final List<String> listingTypes = [
      'All Types',
      'Sale',
      'Hire',
      'Book',
      'Not Specified',
    ];
    final searchController = useTextEditingController();
    final selectedCategorySlug = useState<String>(category.slug);
    final selectedCategory = useState<String>('All Categories');
    final deptValue = useState<String>('All Departments');
    final listingTypeValue = useState<String>('All Types');
    final filteredServices = useState<List<ServiceEntity>>([]);
    final services = useState<List<ServiceEntity>>([]);

    final searchText = useValueListenable(searchController);
    useEffect(() {
      context.read<GetMarketplaceServicesBloc>().add(GetMarketplaceServices(categorySlug: selectedCategorySlug.value));
    }, [selectedCategorySlug.value]);

    useEffect(() {
      final query = searchText.text.toLowerCase().trim();
      final intQuery = int.tryParse(query);
      filteredServices.value = services.value.where((service) {
        // 1. SEARCH FILTER (Text or Number)
        bool matchesSearch =
            query.isEmpty ||
            service.title.toLowerCase().contains(query) ||
            service.description.toLowerCase().contains(query) ||
            service.dept.toLowerCase().contains(query) ||
            (service.listingType?.toLowerCase().contains(query) ?? false) ||
            (intQuery != null &&
                (service.stock == intQuery || service.price == intQuery));

        // 2. DEPARTMENT FILTER
        bool matchesDept =
            deptValue.value == 'All Departments' ||
            service.dept == deptValue.value;

        // 3. LISTING TYPE FILTER
        bool matchesType;
        if (listingTypeValue.value == 'All Types') {
          matchesType = true;
        } else if (listingTypeValue.value == 'Not Specified') {
          matchesType = service.listingType == null;
        } else {
          matchesType =
              service.listingType?.toLowerCase() ==
              listingTypeValue.value.toLowerCase();
        }

        // A service is kept ONLY if it matches ALL three rules
        return matchesSearch && matchesDept && matchesType;
      }).toList();

      return null;
    }, [searchText, deptValue.value, listingTypeValue.value]);

    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child:
            BlocListener<
              GetMarketplaceServicesBloc,
              GetMarketplaceServicesState
            >(
              listener: (context, state) {
                if (state is GetMarketplaceServicesSuccess) {
                  final data = state.services;
                  services.value = data ?? [];
                  filteredServices.value = services.value;
                }
              },
              child:
                  BlocBuilder<
                    GetMarketplaceServicesBloc,
                    GetMarketplaceServicesState
                  >(
                    builder: (context, state) {
                      if (state is GetMarketplaceServicesLoading) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColours.blue,
                          ),
                        );
                      }
                      if (state is GetMarketplaceServicesFailure) {
                        return Center(
                          child: SliverFillRemaining(
                            child: Center(
                              child: ErrorSection(
                                onPressed: () => context
                                    .read<GetMarketplaceServicesBloc>()
                                    .add(
                                      GetMarketplaceServices(
                                        categorySlug: category.slug,
                                      ),
                                    ),
                                errorMessage: state.errorMessage!,
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is GetMarketplaceServicesSuccess) {
                        return CustomScrollView(
                          slivers: [
                            SliverMainAxisGroup(
                              slivers: [
                                MarketplaceTopSection(category: category),
                                CategoryFilterSection(categories: categories!, selectedCategory: selectedCategory,),
                                SliverToBoxAdapter(
                                  child: SearchSection(
                                    onReset: () {
                                      searchController.clear();
                                      deptValue.value = 'All Departments';
                                      listingTypeValue.value = 'All Types';
                                    },
                                    listingTypes: listingTypes,
                                    searchController: searchController,
                                    depts: depts,
                                    onChangeDept: (value) =>
                                        deptValue.value = value!,
                                    onChangeListingType: (value) =>
                                        listingTypeValue.value = value!,
                                  ),
                                ),
                                if (cart != null || (cart?.items.isNotEmpty ?? false)) const CartSummaryContainer(),
                                if (filteredServices.value.isEmpty)
                                  const EmptyServiceBuilder(),
                              ],
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
            ),
      ),
    );
  }
}
