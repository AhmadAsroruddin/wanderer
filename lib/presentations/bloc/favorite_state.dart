part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteFailed extends FavoriteState {
  final String error;
  const FavoriteFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class AddToFavoriteSuccess extends FavoriteState {
  final String success;
  const AddToFavoriteSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class RemovedSuccess extends FavoriteState {
  final String message;
  const RemovedSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AllFavorites extends FavoriteState {
  final List<Favorite> favorite;
  const AllFavorites({required this.favorite});

  @override
  List<Object> get props => [favorite];
}
