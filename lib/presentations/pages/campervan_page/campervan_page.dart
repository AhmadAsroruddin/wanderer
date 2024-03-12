import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderer/presentations/bloc/admin_data_bloc.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/pages/home_page/search_bar.dart';
import 'package:wanderer/presentations/shared/theme.dart';

import '../../../domain/entities/marker.dart';
import '../marker_page/marker_paget.dart';
import 'campervan_list.dart';

class CampervanPage extends StatelessWidget {
  const CampervanPage({super.key});
  static const routeName = '/campervanPage';

  @override
  Widget build(BuildContext context) {
    context.read<AdminDataCubit>().getAllAdminCampervan(false, "");
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AdminDataCubit, AdminDataState>(
          builder: (context, state) {
            print(state);
            if (state is AdminDataCampervan) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Center(
                          child: SearchBarHome(
                            isCamper: true,
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.01,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.01,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${state.campervan.length.toString()} result found",
                            style: GoogleFonts.inter().copyWith(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.campervan.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            Markers marker = await context
                                .read<MarkersCubit>()
                                .getMarkerForFavorite(
                                    state.campervan[index].markerId);

                            context
                                .read<MarkersCubit>()
                                .getMarker(true, marker);
                            Navigator.of(context)
                                .pushNamed(MarkerPage.routeName);
                          },
                          child: CampervanList(
                            image: state.campervan[index].image[0],
                            name: state.campervan[index].name,
                            address: state.campervan[index].address,
                            markerId: state.campervan[index].markerId,
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else if (state is AdminDataFailed) {
              return Container();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
