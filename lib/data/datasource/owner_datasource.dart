import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/data/models/owner_model.dart';
import 'package:wanderer/domain/entities/owner.dart';

abstract class OwnerDataSource {
  Future<void> addOwner(Owner owner, String adminId);
}

class OwnerDataSourceImpl implements OwnerDataSource {
  @override
  Future<void> addOwner(Owner owner, String adminId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('admin')
        .doc(adminId)
        .collection('owner')
        .add(OwnerModel(
                name: owner.name,
                nik: owner.nik,
                photoOnlyUrl: owner.photoOnlyUrl,
                photoWithBodyUrl: owner.photoWithBodyUrl)
            .toMap());
  }
}
