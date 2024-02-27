import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/usecase/uploadImages.dart';
import 'package:wanderer/domain/usecase/uploadOneImage.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  UploadImages uploadImages;
  UploadOneImages uploadOneImages;

  ImageCubit(this.uploadImages, this.uploadOneImages) : super(ImageInitial());

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
    emit(ImageSuccess(links: links));
    return links;
  }

  Future<void> uploadKtp(XFile images) async {
    emit(ImageLoading());
    final result = await uploadOneImages.execute(images);

    result.fold(
      (l) => emit(ImageFailed(error: l)),
      (r) => emit(ImageSuccessKtp(links: r)),
    );
  }

  Future<void> uploadKtpandBody(XFile images) async {
    emit(ImageLoading());
    final result = await uploadOneImages.execute(images);

    result.fold(
      (l) => emit(ImageFailed(error: l)),
      (r) => emit(ImageSuccessKtpandBody(links: r)),
    );
  }
}
