import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/articleUrl.dart';
import 'package:wanderer/domain/repositories/article_repository.dart';

class GetArticleUrl {
  final ArticleRepos articleRepos;

  const GetArticleUrl({required this.articleRepos});

  Future<Either<String, List<ArticleUrl>>> execute(
      bool isSearch, String key) async {
    return await articleRepos.getArticleData(isSearch, key);
  }
}
