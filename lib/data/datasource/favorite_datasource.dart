import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/data/models/favorite_model.dart';
import 'package:wanderer/domain/entities/favorite.dart';

abstract class FavoriteDataSource {
  Future<void> addToFavorite(String userId, String markerId);
  Future<List<String>> getFavorites(String selectedMarkerId, String userId);
  Future<void> removeFromFavorite(String favId, String userId);
  Future<List<Favorite>> getAllFavorites(String userId);
}

class FavoriteDataSourceImpl implements FavoriteDataSource {
  @override
  Future<void> addToFavorite(String userId, String markerId) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final userCollection = firebaseFirestore.collection('users').doc(userId);
    await userCollection
        .collection('favorite')
        .doc(markerId)
        .set(FavoriteModel(markerId: markerId).toMap());
  }

  @override
  Future<List<String>> getFavorites(
      String selectedMarkerId, String userId) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final dataQuery = await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('favorite')
        .get();
    final List<DocumentSnapshot> documents = dataQuery.docs;
    List<String> favorites = [];

    for (var document in documents) {
      // Mengambil data dari dokumen ini
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      favorites.add(data.values.first);
    }

    return favorites;
  }

  @override
  Future<void> removeFromFavorite(String favId, String userId) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('favorite')
        .doc(favId)
        .delete();
  }

  @override
  Future<List<Favorite>> getAllFavorites(String userId) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final dataQuery = await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('favorite')
        .get();

    List<Favorite> favorites = dataQuery.docs
        .map<Favorite>(
          (e) => FavoriteModel.fromDocumentSnapshot(e).toEntity(),
        )
        .toList();
    return favorites;
  }
}
