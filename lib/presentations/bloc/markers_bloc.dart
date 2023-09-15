import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/usecase/addMarker.dart';

import '../../domain/entities/marker.dart';

part 'markers_state.dart';

class MarkersCubit extends Cubit<MarkersState> {
  final AddMarkers _addMarkers;

  MarkersCubit(this._addMarkers) : super(MarkersInitial());

  Future<void> addMarkers(Markers markers, List<XFile> images) async {
    emit(MarkersLoading());

    final result = await _addMarkers.execute(markers, images);

    result.fold(
      (l) => emit(MarkersFailed(error: l)),
      (r) => emit(MarkersSuccess(message: r)),
    );
  }
}
