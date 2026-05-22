import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_state.dart';

enum FavoriteDisplayStatus { unknown, favorited, notFavorited }

FavoriteDisplayStatus favoriteDisplayStatus(
  String serviceId,
  FavoriteState state,
) {
  if (!state.hasLoaded) return FavoriteDisplayStatus.unknown;
  return state.isFavorite(serviceId)
      ? FavoriteDisplayStatus.favorited
      : FavoriteDisplayStatus.notFavorited;
}
