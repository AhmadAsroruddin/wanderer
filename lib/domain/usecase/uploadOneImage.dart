import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/repositories/image_repository.dart';

class UploadOneImages {
  final ImageRepos imageRepos;

  UploadOneImages({required this.imageRepos});

  Future<Either<String, String>> execute(XFile images) async {
    final imageLinks = await imageRepos.uploadOneImage(images);

    return imageLinks;
  }
}
