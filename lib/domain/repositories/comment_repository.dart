import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/comment.dart';

abstract class CommentRepos {
  Future<Either<String, String>> pushComment(Comments comment, String markerId);
}
