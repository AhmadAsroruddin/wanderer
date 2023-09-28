import 'package:equatable/equatable.dart';

class Comments extends Equatable {
  Comments({required this.comment, required this.writer, required this.time});

  final String writer;
  final String comment;
  final DateTime time;

  @override
  List<Object> get props => [writer, comment, time];
}
