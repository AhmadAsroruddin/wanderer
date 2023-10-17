import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/domain/entities/marker.dart';

import '../../../domain/entities/comment.dart';
import '../../bloc/comment_bloc.dart';
import '../../shared/theme.dart';

class CommentTabPage extends StatefulWidget {
  const CommentTabPage({
    super.key,
    required this.widget,
  });

  final Markers widget;

  @override
  State<CommentTabPage> createState() => _CommentTabPageState();
}

class _CommentTabPageState extends State<CommentTabPage> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    context.read<CommentCubit>().getAllComment(widget.widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocBuilder<CommentCubit, CommentState>(
          builder: (context, state) {
            List<Comments> comments = [];

            if (state is AllCommentReceived) {
              if (comments != state.comments) {
                // Periksa apakah komentar telah berubah
                comments = state.comments;
              }
            }

            return SizedBox(
              width: deviceWidth,
              height: deviceHeight * 0.43,
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, item) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.02,
                        vertical: deviceHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: .5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 20,
                          ),
                          SizedBox(
                            width: deviceWidth * 0.01,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  comments[item].writer,
                                  style: GoogleFonts.roboto().copyWith(
                                      fontWeight: extraBold, fontSize: 14),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.005,
                                ),
                                Text(
                                  comments[item].comment,
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: deviceWidth * 0.7,
                height: deviceHeight * 0.05,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.amber,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                  await context.read<CommentCubit>().pushComment(
                      Comments(
                        comment: _commentController.text,
                        writer:
                            firebaseAuth.currentUser!.displayName.toString(),
                        time: Timestamp.fromDate(
                          DateTime.now(),
                        ),
                      ),
                      widget.widget.id);
                  context.read<CommentCubit>().getAllComment(widget.widget.id);
                },
                child: const Icon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.amber,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
