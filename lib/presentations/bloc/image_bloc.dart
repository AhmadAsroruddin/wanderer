import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/usecase/uploadImages.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  UploadImages uploadImages;

  ImageCubit(this.uploadImages) : super(ImageInitial());

  Future<void> upload(List<XFile> images) async {
    emit(ImageLoading());
    final result = await uploadImages.execute(images);

    result.fold(
      (l) => emit(ImageFailed(error: l)),
      (r) => emit(ImageSuccess(links: r)),
    );
  }

  Future<List<String>> uploadImageType(List<XFile> images) async {
    emit(ImageLoading());
    final result = await uploadImages.execute(images);
    List<String> links = [];

    result.fold((l) => l, (r) => links = r);

    return links;
  }
}
