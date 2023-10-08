import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/favorite.dart';

class FavoriteModel extends Equatable {
  const FavoriteModel({
    required this.markerId,
  });

  final String markerId;

  Map<String, dynamic> toMap() {
    return {
      'markerId': markerId,
    };
  }

  static Favorite fromMap(Map<String, dynamic> data) {
    return Favorite(
      markerId: data['markerId'],
    );
  }

  Favorite toEntity() {
    return Favorite(markerId: markerId);
  }

  factory FavoriteModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return FavoriteModel(markerId: data['markerId']);
  }

  @override
  List<Object> get props => [markerId];
}
