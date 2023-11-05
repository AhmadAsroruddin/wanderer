import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/favorite.dart';

abstract class FavoriteRepos {
  Future<Either<String, String>> addToFavorite(String markerId, String userId);
  Future<bool> isFavorite(String selectedMarkerId, String userId);
  Future<Either<String, String>> removeFromFavorite(
      String favId, String userId);
  Future<Either<String, List<Favorite>>> getAllFavorite(String userId);
}
