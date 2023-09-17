import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class MarkerTab extends StatefulWidget {
  const MarkerTab({super.key});

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
          height: deviceHeight,
          child: TabBarView(
            controller: _tabController,
            children: [
              // Isi tab 1
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(
                        vertical: deviceHeight * 0.02,
                        horizontal: 5,
                      ),
                      width: deviceWidth,
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(width: 1),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Perkemahan"),
                          Text("123 km"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Isi tab 2
              Container(
                child: Text(
                  'Tab 2 Content',
                  style: blackTextStyle,
                ),
              ),

              // Isi tab 3
            ],
          ),
        ),
      ],
    );
  }
}
