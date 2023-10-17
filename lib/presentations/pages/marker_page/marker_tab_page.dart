import 'package:flutter/material.dart';
import 'package:wanderer/domain/entities/marker.dart';
import '../../shared/theme.dart';
import 'marker_comment_tab_page.dart';
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
            width: deviceWidth * 0.6,
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
          padding: const EdgeInsets.only(bottom: 10),
          width: deviceWidth,
          height: deviceHeight * 0.5,
          child: TabBarView(
            controller: _tabController,
            children: [
              // Isi tab 1
              DetailsPage(
                markers: widget.markers,
              ),
              CommentTabPage(widget: widget.markers),
            ],
          ),
        ),
      ],
    );
  }
}
