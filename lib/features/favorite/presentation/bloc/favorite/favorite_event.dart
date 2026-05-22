import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent({this.serviceId});
  final String? serviceId;

  @override
  List<Object?> get props => [serviceId];
}

class GetFavorites extends FavoriteEvent {
  const GetFavorites();
}

class AddFavorite extends FavoriteEvent {
  const AddFavorite({required super.serviceId});
}

class RemoveFavorite extends FavoriteEvent {
  const RemoveFavorite({required super.serviceId});
}

class ToggleFavorite extends FavoriteEvent {
  const ToggleFavorite({required super.serviceId});
}

class FavoriteReset extends FavoriteEvent {
  const FavoriteReset();
}
