import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/data/models/tipe_model.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';

abstract class AdminDataSource {
  Future<String> addToAdmin(Admin admin);
  Future<void> addTypeToAdmin(Tipe tipe, String adminId);
}

class AdminDataSourceImpl implements AdminDataSource {
  @override
  Future<String> addToAdmin(Admin admin) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference doc =
        await firebaseFirestore.collection('admin').add(AdminModel(
              name: admin.name,
              noRek: admin.noRek,
              address: admin.address,
              email: admin.email,
              image: admin.image,
              noTelp: admin.noTelp,
              website: admin.website,
              tiktok: admin.tiktok,
              instagram: admin.instagram,
              facilities: admin.facilities,
              time: admin.time,
              description: admin.description,
              category: admin.category,
              latitude: admin.latitude,
              longitude: admin.longitude,
              markerId: admin.markerId,
            ).toMap());
    String adminId = doc.id;
    return adminId;
  }

  @override
  Future<void> addTypeToAdmin(Tipe tipe, String adminId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('admin')
        .doc(adminId)
        .collection('type')
        .add(TipeModel(
                name: tipe.name,
                price: tipe.price,
                facility: tipe.facility,
                images: tipe.images,
                capacity: tipe.capacity,
                description: tipe.description,
                adminId: tipe.adminId)
            .toMap());
  }
}
