import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Comments extends Equatable {
  const Comments({required this.comment, required this.writer, required this.time});

  final String writer;
  final String comment;
  final Timestamp time;

  @override
  List<Object> get props => [writer, comment, time];
}
