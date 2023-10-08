import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/favorite_repository.dart';

class RemoveFromFavorite {
  final FavoriteRepos favoriteRepos;

  RemoveFromFavorite({required this.favoriteRepos});

  Future<Either<String, String>> execute(String favId, String userId) {
    return favoriteRepos.removeFromFavorite(favId, userId);
  }
}
