import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/data/models/articleUrl_model.dart';
import 'package:wanderer/domain/entities/articleUrl.dart';

abstract class ArticleDataSource {
  Future<List<ArticleUrl>> getArticleUrl(bool isSearch, String key);
}

class ArticleDataSourceImpl implements ArticleDataSource {
  @override
  Future<List<ArticleUrl>> getArticleUrl(bool isSearch, String key) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> query;

    if (isSearch == true) {
      print(key);
      query = await firestore
          .collection("article url")
          .where('title', isGreaterThanOrEqualTo: key)
          .where('title', isLessThanOrEqualTo: '$key\uf8ff')
          .get();
      print(query.size);
    } else {
      query = await firestore.collection("article url").get();
    }

    final List<ArticleUrl> articleData = query.docs.map<ArticleUrl>((e) {
      return ArticleModel.fromDocumentSnapshot(e).toEntity();
    }).toList();

    return articleData;
  }
}
