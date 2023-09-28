import 'package:equatable/equatable.dart';

import '../../domain/entities/comment.dart';

class CommentModel extends Equatable {
  const CommentModel(
      {required this.comment, required this.writer, required this.time});

  final String writer;
  final String comment;
  final DateTime time;

  Map<String, dynamic> toMap() {
    return {
      'writer': writer,
      'comment': comment,
      'time': time,
    };
  }

  static Comments fromMap(Map<String, dynamic> data) {
    return Comments(
      comment: data['comment'],
      time: data['time'],
      writer: data['writer'],
    );
  }

  @override
  List<Object> get props => [writer, comment, time];
}
