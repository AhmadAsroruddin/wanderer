import 'package:wanderer/domain/repositories/favorite_repository.dart';

class IsFavorite {
  FavoriteRepos favoriteRepos;

  IsFavorite({required this.favoriteRepos});

  Future<bool> execute(String selectedMarkerId, String userId) {
    return favoriteRepos.isFavorite(selectedMarkerId, userId);
  }
}
