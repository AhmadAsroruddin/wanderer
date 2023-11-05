import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/data/models/articleUrl_model.dart';
import 'package:wanderer/domain/entities/articleUrl.dart';

abstract class ArticleDataSource {
  Future<List<ArticleUrl>> getArticleUrl();
}

class ArticleDataSourceImpl implements ArticleDataSource {
  @override
  Future<List<ArticleUrl>> getArticleUrl() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final query = await firestore.collection("article url").get();

    final List<ArticleUrl> articleData = query.docs.map<ArticleUrl>((e) {
      return ArticleModel.fromDocumentSnapshot(e).toEntity();
    }).toList();

    return articleData;
  }
}
