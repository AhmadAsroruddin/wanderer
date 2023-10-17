import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/domain/entities/comment.dart';

import '../models/comment_model.dart';

abstract class CommentDataSource {
  Future<void> pushComments(Comments comments, String markerId);
  Future<List<Comments>> getComments(String markerId);
}

class CommentDataSourceImpl implements CommentDataSource {
  @override
  Future<void> pushComments(Comments comments, String markerId) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final markerCollection =
        firebaseFirestore.collection('markers').doc(markerId);

    await markerCollection.collection('comments').add(CommentModel(
            comment: comments.comment,
            writer: comments.writer,
            time: comments.time)
        .toMap());
  }

  @override
  Future<List<Comments>> getComments(String markerId) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final dataQuery = await firebaseFirestore
        .collection('markers')
        .doc(markerId)
        .collection('comments')
        .get();

    final List<Comments> comments = dataQuery.docs
        .map<Comments>(
            (doc) => CommentModel.fromDocumentSnapshot(doc).toEntity())
        .toList();
    return comments;
  }
}
