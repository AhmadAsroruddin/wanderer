import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/domain/entities/comment.dart';
import 'package:wanderer/domain/entities/marker.dart';
import 'package:wanderer/presentations/bloc/comment_bloc.dart';

import '../../shared/theme.dart';
import 'marker_detail_page.dart';

class MarkerTab extends StatefulWidget {
  const MarkerTab({required this.markers, super.key});

  final Markers markers;

  @override
  State<MarkerTab> createState() => _MarkerTabState();
}

class _MarkerTabState extends State<MarkerTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: deviceWidth * 0.5,
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.amber,
              tabs: const [
                Tab(
                  text: 'Details',
                ),
                Tab(text: 'Comments'),
              ],
            ),
          ),
        ),
        Container(
          width: deviceWidth,
          height: deviceHeight * 0.5,
          child: TabBarView(
            controller: _tabController,
            children: [
              // Isi tab 1
              DetailsPage(
                markers: widget.markers,
              ),
              // Isi tab 2
              Column(
                children: <Widget>[
                  Container(
                    width: deviceWidth,
                    height: deviceHeight * 0.43,
                    child: ListView.builder(
                      itemCount: 5,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Nama",
                                        style: GoogleFonts.roboto().copyWith(
                                            fontWeight: extraBold,
                                            fontSize: 14),
                                      ),
                                      const Text(
                                        "Tempat ini sangat nyaman dikunjungi bersama keluarga, susananya indah. Selain itu banyak makanan pantai yang membuat saya selera i love this place, semoga bisa datang ke sini lagi!!!!!!",
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
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                gapPadding: 1,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<CommentCubit>().pushComment(
                                Comments(
                                    comment: "ini komentar pertama saya",
                                    writer: widget.markers.userId,
                                    time: DateTime.now()),
                                widget.markers.id);
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
              )

              // Isi tab 3
            ],
          ),
        ),
      ],
    );
  }
}
