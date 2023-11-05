import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/articleUrl.dart';

abstract class ArticleRepos {
  Future<Either<String, List<ArticleUrl>>> getArticleData();
}
