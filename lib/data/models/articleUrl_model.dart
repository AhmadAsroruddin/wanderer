import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/articleUrl.dart';

class ArticleModel extends Equatable {
  const ArticleModel(
      {required this.imageUrl, required this.url, required this.title});
  final String imageUrl;
  final String url;
  final String title;

  factory ArticleModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ArticleModel(
      imageUrl: data['imageUrl'],
      url: data['url'],
      title: data['title'],
    );
  }

  ArticleUrl toEntity() {
    return ArticleUrl(photoUrl: imageUrl, url: url, title: title);
  }

  @override
  List<Object> get props => [imageUrl, url, title];
}
