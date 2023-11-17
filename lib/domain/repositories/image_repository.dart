import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageRepos {
  Future<Either<String, List<String>>> uploadImage(List<XFile> images);
  Future<Either<String, String>> uploadOneImage(XFile images);
}
