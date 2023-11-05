import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/favorite_datasource.dart';
import 'package:wanderer/domain/entities/favorite.dart';
import 'package:wanderer/domain/repositories/favorite_repository.dart';

class FavoriteReposImpl implements FavoriteRepos {
  final FavoriteDataSource favoriteDataSource;

  FavoriteReposImpl({required this.favoriteDataSource});

  @override
  Future<Either<String, String>> addToFavorite(
      String markerId, String userId) async {
    try {
      await favoriteDataSource.addToFavorite(
        userId,
        markerId,
      );
      return const Right("Favorite added");
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  @override
  Future<bool> isFavorite(String selectedMarkerId, String userId) async {
    List<String> favorites =
        await favoriteDataSource.getFavorites(selectedMarkerId, userId);
    bool hasil = false;
    for (int i = 0; i <= favorites.length - 1; i++) {
      if (selectedMarkerId == favorites[i]) {
        hasil = true;
      }
    }
    return hasil;
  }

  @override
  Future<Either<String, String>> removeFromFavorite(
      String favId, String userId) async {
    try {
      await favoriteDataSource.removeFromFavorite(favId, userId);
      return const Right("removed from favorites");
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Favorite>>> getAllFavorite(String userId) async {
    try {
      final result = await favoriteDataSource.getAllFavorites(userId);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
