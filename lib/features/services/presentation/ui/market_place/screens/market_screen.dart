import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_state.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:ambuhub/features/services/presentation/ui/category_info/widget/dept_section_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/category_info/widget/search_section.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/cart_summary_container.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/custom_snack_bar.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/empty_service_builder.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/login_prompt_container.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/category_filter_section.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/market_place_top_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MarketplaceScreen extends HookWidget {
  final ServiceCategoryEntity category;
  const MarketplaceScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categories = context
        .read<GetServiceCategoriesBloc>()
        .state
        .serviceCategories;
    final List<String> listingTypes = [
      'All Types',
      'Sale',
      'Hire',
      'Book',
      'Not Specified',
    ];
    final searchController = useTextEditingController();
    final selectedCategory = useState<String>(category.slug);
    final deptValue = useState<String>('All Departments');
    final listingTypeValue = useState<String>('All Types');
    final filteredServices = useState<List<ServiceEntity>>([]);
    final services = useState<List<ServiceEntity>>([]);
    final isLoggedIn = context.read<AuthBloc>().state.data != null;
    final selectedCategoryEntity = useState<ServiceCategoryEntity>(category);
    final searchText = useValueListenable(searchController);

    final depts = useMemoized(() {
      final names = selectedCategoryEntity.value.departments
          .map((dept) => dept.name)
          .toList();
      names.insert(0, 'All Departments');
      return names;
    }, [selectedCategoryEntity.value]);

    useEffect(() {
      selectedCategory.value = category.slug;
      selectedCategoryEntity.value = category;
      return null;
    }, [category.slug]);

    useEffect(() {
      final slug = selectedCategory.value;
      final matchedCategory = categories
          ?.where((c) => c.slug == slug)
          .firstOrNull;
      if (matchedCategory != null) {
        selectedCategoryEntity.value = matchedCategory;
      }
      deptValue.value = 'All Departments';
      listingTypeValue.value = 'All Types';
      searchController.clear();

      final marketplaceBloc = context.read<GetMarketplaceServicesBloc>();
      final currentState = marketplaceBloc.state;
      if (currentState is GetMarketplaceServicesSuccess &&
          currentState.categorySlug == slug) {
        final data = currentState.services ?? [];
        services.value = data;
        filteredServices.value = data;
      } else {
        services.value = [];
        filteredServices.value = [];
      }

      marketplaceBloc.add(GetMarketplaceServices(categorySlug: slug));
      return null;
    }, [selectedCategory.value]);

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
    }, [searchText, deptValue.value, listingTypeValue.value, services.value]);

    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child:
            BlocListener<
              GetMarketplaceServicesBloc,
              GetMarketplaceServicesState
            >(
              listener: (context, state) {
                if (state is GetMarketplaceServicesSuccess &&
                    state.categorySlug == selectedCategory.value) {
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
                        return CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              child: Center(
                                child: ErrorSection(
                                  onPressed: () => context
                                      .read<GetMarketplaceServicesBloc>()
                                      .add(
                                        GetMarketplaceServices(
                                          categorySlug: selectedCategory.value,
                                        ),
                                      ),
                                  errorMessage: state.errorMessage!,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is GetMarketplaceServicesSuccess &&
                          state.categorySlug == selectedCategory.value) {
                        return MultiBlocListener(
                          listeners: [
                            BlocListener<CartBloc, CartState>(
                              listenWhen: (previous, current) =>
                                  current is CartSuccess &&
                                  previous is CartLoading &&
                                  previous.isAddingToCart,
                              listener: (context, state) {
                                if (state is CartSuccess) {
                                  showCustomFlushBar(
                                    context,
                                    message: 'Added to cart',
                                    title: 'Success',
                                    type: AppFlushBarType.success,
                                  );
                                }
                                if (state is CartFailure) {
                                  showCustomFlushBar(
                                    context,
                                    message: 'Failed to add to cart',
                                    title: 'Error',
                                    type: AppFlushBarType.error,
                                  );
                                }
                              },
                            ),
                            BlocListener<FavoriteBloc, FavoriteState>(
                              listenWhen: (previous, current) =>
                                  current.lastAddedServiceId != null &&
                                  current.lastAddedServiceId !=
                                      previous.lastAddedServiceId,
                              listener: (context, state) {
                                showCustomFlushBar(
                                  context,
                                  message: 'Added to favorites',
                                  title: 'Success',
                                  type: AppFlushBarType.success,
                                );
                              },
                            ),
                          ],
                          child: CustomScrollView(
                            slivers: [
                              SliverMainAxisGroup(
                                slivers: [
                                  MarketplaceTopSection(
                                    category: selectedCategoryEntity.value,
                                  ),
                                  if (!isLoggedIn) const LoginPromptContainer(),
                                  CategoryFilterSection(
                                    categories: categories!,
                                    selectedCategory: selectedCategory,
                                  ),
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
                                      deptValue: deptValue.value,
                                      listingTypeValue: listingTypeValue.value,
                                      onChangeDept: (value) =>
                                          deptValue.value = value!,
                                      onChangeListingType: (value) =>
                                          listingTypeValue.value = value!,
                                    ),
                                  ),
                                  const CartSummaryContainer(),
                                  ...selectedCategoryEntity.value.departments
                                      .map((dept) {
                                        final List<ServiceEntity> deptServices =
                                            filteredServices.value
                                                .where(
                                                  (e) => e.dept == dept.name,
                                                )
                                                .toList();
                                        if (deptServices.isEmpty) {
                                          return const SliverToBoxAdapter(
                                            child: SizedBox.shrink(),
                                          );
                                        }
                                        return DeptSectionBuilder(
                                          deptName: dept.name,
                                          services: deptServices,
                                        );
                                      }),

                                  if (filteredServices.value.isEmpty)
                                    const EmptyServiceBuilder(),
                                ],
                              ),
                            ],
                          ),
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
