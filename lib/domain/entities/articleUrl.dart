import 'package:equatable/equatable.dart';

class ArticleUrl extends Equatable {
  const ArticleUrl(
      {required this.photoUrl, required this.url, required this.title});

  final String photoUrl;
  final String url;
  final String title;
  @override
  List<Object> get props => [photoUrl, url, title];
}
