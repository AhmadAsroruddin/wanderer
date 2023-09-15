import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/repositories/image_repository.dart';

class ImageReposImpl extends ImageRepos {
  @override
  Future<Either<String, List<String>>> uploadImage(List<XFile> images) async {
    try {
      List<String> links = [];
      for (var image in images) {
        final ext = image.path.split('.').last.toLowerCase();

        if (ext != 'jpg' && ext != 'png') {
          throw (Exception("File harus berjenis png atau jpg"));
        }

        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('markers')
            .child('${DateTime.now().millisecondsSinceEpoch}.$ext');
        final File imageFile = File(image.path);
        final UploadTask uploadTask = storageReference.putFile(imageFile);
        final TaskSnapshot taskSnapshot =
            await uploadTask.whenComplete(() => null);
        final imageURL = await taskSnapshot.ref.getDownloadURL();
        links.add(imageURL);
      }
      return Right(links);
    } catch (e) {
      String error = "$e";
      return Left(error);
    }
  }
}
