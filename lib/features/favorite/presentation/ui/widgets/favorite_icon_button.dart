import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_event.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_state.dart';
import 'package:ambuhub/features/favorite/presentation/ui/widgets/favorite_display_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteIconButton extends StatelessWidget {
  final String serviceId;

  const FavoriteIconButton({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.read<AuthBloc>().state.data != null;

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) =>
          previous.favoriteServiceIds != current.favoriteServiceIds ||
          previous.hasLoaded != current.hasLoaded ||
          previous.pendingServiceId != current.pendingServiceId,
      builder: (context, state) {
        final status = favoriteDisplayStatus(serviceId, state);
        final isPending = state.pendingServiceId == serviceId;

        final isFavorited = status == FavoriteDisplayStatus.favorited;
        final icon = isFavorited ? Icons.favorite : Icons.favorite_outline;
        final iconColor =
            isFavorited ? AppColours.rosePink : AppColours.white;
        final isLoading =
            _isAddingThisServiceToFavorite(state, serviceId);

        return GestureDetector(
          onTap: isLoggedIn
              ? () {
                  context.read<FavoriteBloc>().add(
                        ToggleFavorite(serviceId: serviceId),
                      );
                }
              : () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                },
          child: Opacity(
            opacity: isPending ? 0.5 : 1,
            child: isLoading
                ? SizedBox(
                    height: 15.sp,
                    width: 15.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColours.white,
                    ),
                  )
                : Icon(
                    icon,
                    color: iconColor,
                    size: 15.sp,
                  ),
          ),
        );
      },
    );
  }
  bool _isAddingThisServiceToFavorite(FavoriteState state, String serviceId) {
    return state is FavoriteLoading && state.pendingServiceId == serviceId;
  }
}
