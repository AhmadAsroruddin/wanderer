import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/comment_datasource.dart';
import 'package:wanderer/domain/entities/comment.dart';
import 'package:wanderer/domain/repositories/comment_repository.dart';

class CommentsReposImpl implements CommentRepos {
  final CommentDataSource commentDataSource;

  CommentsReposImpl({required this.commentDataSource});

  @override
  Future<Either<String, String>> pushComment(
      Comments comment, String markerId) async {
    try {
      await commentDataSource.pushComments(comment, markerId);

      return const Right("Comment berhasil ditambahkan");
    } catch (e) {
      print(e);
      return Left("Error : $e");
    }
  }

  @override
  Future<Either<String, List<Comments>>> getComments(String markerId) async {
    try {
      final data = await commentDataSource.getComments(markerId);
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
