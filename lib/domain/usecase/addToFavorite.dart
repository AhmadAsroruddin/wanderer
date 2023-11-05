import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/favorite_repository.dart';

class AddToFavorite {
  final FavoriteRepos favoriteRepos;

  AddToFavorite({required this.favoriteRepos});

  Future<Either<String, String>> execute(String userId, String markerId) {
    return favoriteRepos.addToFavorite(markerId, userId);
  }
}
