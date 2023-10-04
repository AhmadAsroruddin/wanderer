import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/comment.dart';
import 'package:wanderer/domain/repositories/comment_repository.dart';

class GetAllComments {
  final CommentRepos commentRepos;

  GetAllComments({required this.commentRepos});

  Future<Either<String, List<Comments>>> execute(String markerId) async {
    return commentRepos.getComments(markerId);
  }
}
