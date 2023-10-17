import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/usecase/pushComments.dart';
import 'package:wanderer/domain/usecase/getAllComments.dart';

import '../../domain/entities/comment.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  PushComment pushCommentUseCase;
  GetAllComments getAllComments;

  CommentCubit(this.pushCommentUseCase, this.getAllComments)
      : super(CommentInitial());

  Future<void> pushComment(Comments comments, String markerId) async {
    emit(CommentLoading());

    final result = await pushCommentUseCase.execute(comments, markerId);

    result.fold(
      (l) => emit(CommentFailed(error: l)),
      (r) => emit(CommentSuccess(success: r)),
    );
  }

  Future<void> getAllComment(String markerId) async {
    emit(CommentLoading());
    final result = await getAllComments.execute(markerId);
    print("bloc");
    result.fold(
      (l) => emit(CommentFailed(error: l)),
      (r) => emit(AllCommentReceived(comments: r)),
    );
  }
}
