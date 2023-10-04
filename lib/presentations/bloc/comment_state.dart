part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentFailed extends CommentState {
  final String error;
  const CommentFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class CommentSuccess extends CommentState {
  final String success;
  const CommentSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class AllCommentReceived extends CommentState {
  final List<Comments> comments;

  const AllCommentReceived({required this.comments});

  @override
  List<Object> get props => [comments];
}
