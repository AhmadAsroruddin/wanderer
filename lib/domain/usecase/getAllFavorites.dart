import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/favorite.dart';
import 'package:wanderer/domain/repositories/favorite_repository.dart';

class GetAllFavorites {
  FavoriteRepos favoriteRepos;
  GetAllFavorites({required this.favoriteRepos});

  Future<Either<String, List<Favorite>>> execute(String userId) {
    return favoriteRepos.getAllFavorite(userId);
  }
}
