import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/articleUrl.dart';
import 'package:wanderer/domain/usecase/getArticleUrl.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  GetArticleUrl getArticleUrl;

  ArticleCubit(this.getArticleUrl) : super(ArticleInitial());

  Future<void> getArticle(bool isSearch, String key) async {
    emit(ArticleLoading());

    final result = await getArticleUrl.execute(isSearch, key);

    result.fold(
      (l) => emit(ArticleError(error: l)),
      (r) => emit(ArticleSuccess(data: r)),
    );
  }
}
