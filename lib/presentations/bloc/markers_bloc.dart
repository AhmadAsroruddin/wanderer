import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/usecase/addMarker.dart';
import 'package:wanderer/domain/usecase/addMarkerAdmin.dart';
import 'package:wanderer/domain/usecase/getAllMarkers.dart';
import 'package:wanderer/domain/usecase/updateUserIdMarker.dart';

import '../../domain/entities/marker.dart';

part 'markers_state.dart';

class MarkersCubit extends Cubit<MarkersState> {
  final AddMarkers _addMarkers;
  final GetAllMarkers _getAllMarkers;
  final AddMarkerAdmin _addMarkerAdmin;
  final UpdateUseridMarker _updateUseridMarker;

  MarkersCubit(this._addMarkers, this._getAllMarkers, this._addMarkerAdmin,
      this._updateUseridMarker)
      : super(MarkersInitial());

  Future<void> addMarkers(Markers markers, List<XFile> images, bool adminCheck,
      List<dynamic> link) async {
    emit(MarkersLoading());

    final result = await _addMarkers.execute(markers, images, adminCheck, link);

    if (adminCheck == true) {
      result.fold(
        (l) => emit(MarkersFailed(error: l)),
        (r) => emit(MarkersSuccess(message: r, isClicked: false)),
      );
    } else {
      result.fold(
        (l) => emit(const MarkersFailed(error: "Marker berhasil ditambahkan")),
        (r) => emit(MarkersSuccess(message: r, isClicked: false)),
      );
    }
  }

  Future<String> addMarkerAdmin(Markers markers, List<dynamic> links) async {
    final result = await _addMarkerAdmin.execute(markers, links);
    return result;
  }

  Future<List<Markers>> getAllMarkers() async {
    final result = await _getAllMarkers.execute();

    return result;
  }

  void getMarker(bool isClicked, Markers marker) {
    emit(GetOneMarker(
        marker: marker, isClicked: isClicked)); // Toggle nilai boolean
  }

  Future<void> update(String id, String markerId) async {
    await _updateUseridMarker.execute(id, markerId);
  }
}
