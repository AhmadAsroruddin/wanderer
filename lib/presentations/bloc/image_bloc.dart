import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/usecase/uploadImages.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final UploadImages _uploadImages;

  ImageCubit(this._uploadImages) : super(ImageInitial());

  Future<void> uploadImages(List<XFile> images) async {
    emit(ImageLoading());
    final result = await _uploadImages.execute(images);

    result.fold(
      (l) => emit(ImageFailed(error: l)),
      (r) => emit(ImageSuccess(message: r)),
    );
  }
}
