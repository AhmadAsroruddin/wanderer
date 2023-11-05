import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/home_page/search_bar.dart';
import 'package:wanderer/presentations/shared/theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  static const routeName = "/searchPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MarkersCubit, MarkersState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: deviceWidth * 1,
                    child: SearchBarHome(
                      isSearchPage: true,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 0.04,
                    vertical: deviceHeight * 0.01,
                  ),
                  child: state is SearchMarkers
                      ? Text("${state.marker.length} result found")
                      : const Text("0 result found"),
                ),
                if (state is SearchMarkers)
                  Expanded(
                    child: state.marker.isEmpty
                        ? const Center(
                            child: Text("No Result Found"),
                          )
                        : ListView.builder(
                            itemCount: state.marker.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: deviceWidth * 0.05,
                                  vertical: deviceWidth * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: deviceWidth * 0.3,
                                      height: deviceHeight * 0.12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              state.marker[index].image[0],
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    SizedBox(
                                      width: deviceWidth * 0.02,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: deviceWidth * 0.55,
                                          child: Text(
                                            state.marker[index].name,
                                            style: blackTextStyle.copyWith(
                                              fontWeight: bold,
                                              fontSize: deviceWidth * 0.035,
                                            ),
                                          ),
                                        ),
                                        IconList(
                                          icon: "marker",
                                          data: state.marker[index].address,
                                        ),
                                        const IconList(
                                          icon: "jam",
                                          data: "12.00 - 24.00",
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}

class IconList extends StatelessWidget {
  const IconList({
    super.key,
    required this.icon,
    required this.data,
  });

  final String icon;
  final String data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth * 0.55,
      child: Row(
        children: <Widget>[
          Container(
            width: deviceWidth * 0.06,
            height: deviceHeight * 0.025,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/$icon.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: deviceWidth * 0.01,
          ),
          Container(
            width: deviceWidth * 0.47,
            child: Text(
              data,
              textAlign: TextAlign.start,
              style: blackTextStyle.copyWith(fontSize: deviceWidth * 0.03),
            ),
          )
        ],
      ),
    );
  }
}
