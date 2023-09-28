import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/comment.dart';
import 'package:wanderer/domain/repositories/comment_repository.dart';

class PushComment {
  final CommentRepos commentRepos;

  PushComment({required this.commentRepos});

  Future<Either<String, String>> execute(
      Comments comments, String markerId) async {
    return commentRepos.pushComment(comments, markerId);
  }
}
