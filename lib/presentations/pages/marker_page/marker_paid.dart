import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';

import '../../../domain/entities/admin.dart';
import '../../bloc/admin_data_bloc.dart';
import '../../shared/theme.dart';
import 'marker_detail_page.dart';

class PaidMarkerPage extends StatefulWidget {
  const PaidMarkerPage({
    super.key,
    required this.widget,
  });

  final DetailsPage widget;

  @override
  State<PaidMarkerPage> createState() => _PaidMarkerPageState();
}

class _PaidMarkerPageState extends State<PaidMarkerPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AdminDataCubit>().getAdminData(widget.widget.markers.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AdminCubit>().getAdminData(widget.widget.markers.id);
    return DetailContainer(
      widget: widget.widget,
      widgetChild: BlocBuilder<AdminDataCubit, AdminDataState>(
          builder: (context, state) {
        if (state is AdminDataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AdminDataSuccess) {
          return Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: deviceWidth * 0.01),
                      height: deviceHeight * 0.04,
                      width: deviceWidth * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: deviceWidth * 0.5,
                            height: deviceHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 0.5),
                              image: DecorationImage(
                                image: NetworkImage(
                                  state.data.image[0],
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Text("data")
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
