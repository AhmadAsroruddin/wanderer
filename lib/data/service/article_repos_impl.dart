import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/article_datasource.dart';
import 'package:wanderer/domain/entities/articleUrl.dart';
import 'package:wanderer/domain/repositories/article_repository.dart';

class ArticleReposImpl implements ArticleRepos {
  final ArticleDataSource articleDataSource;

  const ArticleReposImpl({required this.articleDataSource});

  @override
  Future<Either<String, List<ArticleUrl>>> getArticleData(
      bool isSearch, String key) async {
    try {
      final result = await articleDataSource.getArticleUrl(isSearch, key);

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
