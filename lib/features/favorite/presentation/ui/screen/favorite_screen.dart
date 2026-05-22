import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';
import 'package:ambuhub/core/widgets/client_app_scaffold.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_event.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_state.dart';
import 'package:ambuhub/features/favorite/presentation/ui/widgets/build_header.dart';
import 'package:ambuhub/features/favorite/presentation/ui/widgets/favourites_service_builder.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_state.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const LinearGradient _favouritesTitleGradient = LinearGradient(
    colors: [AppColours.hirePurpleDeep, AppColours.hireMagentaRose],
  );

  static const String _emptyDescription =
      'Marketplace listings you saved for quick access. Open a category or hire flow when you are ready.';

  @override
  Widget build(BuildContext context) {
    return ClientAppScaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favoriteState) {
          if (favoriteState.isInitialLoad) {
            if (favoriteState is FavoriteFailure) {
              return Center(
                child: ErrorSection(
                  onPressed: () {
                    context.read<FavoriteBloc>().add(const GetFavorites());
                    context
                        .read<GetServiceCategoriesBloc>()
                        .add(const GetServiceCategories());
                  },
                  errorMessage: favoriteState.errorMessage ??
                      'An error occurred while loading favorites',
                ),
              );
            }
            return const Center(child: CupertinoActivityIndicator());
          }

          return BlocBuilder<GetServiceCategoriesBloc,
              GetServiceCategoriesState>(
            builder: (context, categoriesState) {
              final serviceCategories = categoriesState.serviceCategories;

              if (serviceCategories == null) {
                if (categoriesState is GetServiceCategoriesError) {
                  return Center(
                    child: ErrorSection(
                      onPressed: () {
                        context
                            .read<GetServiceCategoriesBloc>()
                            .add(const GetServiceCategories());
                      },
                      errorMessage: categoriesState.error ??
                          'An error occurred while loading categories',
                    ),
                  );
                }
                return const Center(child: CupertinoActivityIndicator());
              }

              if (favoriteState.services.isEmpty) {
                return _buildEmptyContentPageBuilder(
                  context,
                  serviceCategories,
                );
              }

              return SizedBox.expand(
                child: FavouritesServiceBuilder(
                  services: favoriteState.services,
                  serviceCategories: serviceCategories,
                  emptyDescription: _emptyDescription,
                  navigationText: 'View all categories',
                  gradient: _favouritesTitleGradient,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyContentPageBuilder(
    BuildContext context,
    List<ServiceCategoryEntity> serviceCategories,
  ) {
    return EmptyContentPageBuilder(
      dottedBorderColor: AppColours.hireMagentaRose,
      icon: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BuildHeader(
            emptyDescription: _emptyDescription,
            gradient: _favouritesTitleGradient,
          ),
        ],
      ),
      placeholderLines: const [
        'You have not saved any listings yet. Use the heart on a ',
        'service card while browsing to add it here.',
      ],
      navigationText: 'Explore the marketplace',
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.markerScreen,
        arguments: serviceCategories.first,
      ),
    );
  }
}
