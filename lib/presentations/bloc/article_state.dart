part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleError extends ArticleState {
  final String error;
  const ArticleError({required this.error});

  @override
  List<Object> get props => [error];
}

class ArticleSuccess extends ArticleState {
  final List<ArticleUrl> data;

  const ArticleSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
