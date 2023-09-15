import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/repositories/image_repository.dart';

class UploadImages {
  final ImageRepos imageRepos;

  UploadImages({required this.imageRepos});

  Future<Either<String, List<String>>> execute(List<XFile> images) async {
    final imageLinks = await imageRepos.uploadImage(images);

    return imageLinks;
  }
}
