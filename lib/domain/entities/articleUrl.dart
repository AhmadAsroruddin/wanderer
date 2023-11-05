import 'package:equatable/equatable.dart';

class ArticleUrl extends Equatable {
  final String photoUrl;
  final String url;
  final String title;

  const ArticleUrl(
      {required this.photoUrl, required this.url, required this.title});

  @override
  List<Object> get props => [photoUrl, url, title];
}
