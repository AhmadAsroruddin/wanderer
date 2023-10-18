import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/data/models/tipe_model.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';

abstract class AdminDataSource {
  Future<String> addToAdmin(Admin admin, String adminId);
  Future<void> addTypeToAdmin(Tipe tipe, String adminId);
  Future<List<Admin>> getAdmin(String markerId);
  Future<List<Tipe>> getTypes(String adminId);
}

class AdminDataSourceImpl implements AdminDataSource {
  @override
  Future<String> addToAdmin(Admin admin, String markerId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference doc =
        await firebaseFirestore.collection('admin').add(AdminModel(
              id: admin.id,
              userId: admin.userId,
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
              markerId: markerId,
            ).toMap());
    String adminId = doc.id;
    await firebaseFirestore
        .collection('admin')
        .doc(adminId)
        .update({'id': adminId});
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

  @override
  Future<List<Admin>> getAdmin(String markerId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final adminQuery = await firebaseFirestore
        .collection('admin')
        .where('markerId', isEqualTo: markerId)
        .get();

    final List<Admin> admin = adminQuery.docs
        .map<Admin>((doc) => AdminModel.fromDocumentSnapshot(doc).toEntity())
        .toList();

    return admin;
  }

  @override
  Future<List<Tipe>> getTypes(String adminId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final dataQuery = await firebaseFirestore
        .collection('admin')
        .doc("PnCcajPkmVGxhRKJJ4sP")
        .collection('type')
        .get();
    print("data ${dataQuery.size}");
    final List<Tipe> tipe = dataQuery.docs
        .map<Tipe>((doc) => TipeModel.fromDocumentSnapshot(doc).toEntity())
        .toList();

    return tipe;
  }
}
