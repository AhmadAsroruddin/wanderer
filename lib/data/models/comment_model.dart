import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/comment.dart';

class CommentModel extends Equatable {
  const CommentModel(
      {required this.comment, required this.writer, required this.time});

  final String writer;
  final String comment;
  final Timestamp time;

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

  Comments toEntity() {
    return Comments(comment: comment, writer: writer, time: time);
  }

  factory CommentModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return CommentModel(
      comment: data['comment'],
      writer: data['writer'],
      time: data['time'],
    );
  }

  @override
  List<Object> get props => [writer, comment, time];
}
