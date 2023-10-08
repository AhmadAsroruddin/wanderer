import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/favorite.dart';
import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/domain/usecase/addToFavorite.dart';
import 'package:wanderer/domain/usecase/getAllFavorites.dart';
import 'package:wanderer/domain/usecase/isFavorite.dart';
import 'package:wanderer/domain/usecase/removedFromFavorite.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  AddToFavorite addToFavorite;
  IsFavorite isFavorite;
  RemoveFromFavorite removeFromFavorite;
  GetAllFavorites getAllFavorites;

  FavoriteCubit(this.addToFavorite, this.isFavorite, this.removeFromFavorite,
      this.getAllFavorites)
      : super(FavoriteInitial());

  Future<void> addMarkerToFavorite(
      Markers markers, String userId, String markerId) async {
    final result = await addToFavorite.execute(markers, userId, markerId);

    result.fold(
      (l) => emit(FavoriteFailed(error: l)),
      (r) => emit(AddToFavoriteSuccess(success: r)),
    );
  }

  Future<bool> favoriteCheck(String selectedMarkerId, String userId) {
    final result = isFavorite.execute(selectedMarkerId, userId);

    return result;
  }

  Future<void> remove(String favId, String userId) async {
    final result = await removeFromFavorite.execute(favId, userId);

    result.fold(
      (l) => {emit(FavoriteFailed(error: l))},
      (r) => {emit(RemovedSuccess(message: r))},
    );
  }

  Future<void> getAllFav(String userId) async {
    emit(FavoriteLoading());
    final result = await getAllFavorites.execute(userId);

    result.fold(
      (l) => emit(FavoriteFailed(error: l)),
      (r) => emit(AllFavorites(favorite: r)),
    );
  }
}
