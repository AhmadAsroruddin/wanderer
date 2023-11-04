import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/data/models/tipe_model.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/tipe.dart';

abstract class AdminDataSource {
  Future<String> addToAdmin(Admin admin, String adminId);
  Future<void> addTypeToAdmin(Tipe tipe, String adminId);
  Future<Admin> getAdmin(String markerId);
  Future<List<Tipe>> getTypes(String adminId);
  Future<void> updateAdminId(String adminId, String userId);
  Future<List<Admin>> getCampervanRental();
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
                adminId: adminId)
            .toMap());
  }

  @override
  Future<Admin> getAdmin(String adminId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final adminQuery = await firebaseFirestore
        .collection('admin')
        .where('id', isEqualTo: adminId)
        .get();
    final List<Admin> admin = adminQuery.docs
        .map<Admin>((doc) => AdminModel.fromDocumentSnapshot(doc).toEntity())
        .toList();

    return admin.first;
  }

  @override
  Future<List<Tipe>> getTypes(String adminId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final dataQuery = await firebaseFirestore
        .collection('admin')
        .doc(adminId)
        .collection('type')
        .get();

    final List<Tipe> tipe = dataQuery.docs
        .map<Tipe>((doc) => TipeModel.fromDocumentSnapshot(doc).toEntity())
        .toList();

    return tipe;
  }

  @override
  Future<void> updateAdminId(String adminId, String userId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('admin').doc(adminId).update({'userId': userId});
  }

  @override
  Future<List<Admin>> getCampervanRental() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final dataQuery = await firestore
        .collection('admin')
        .where('category', isEqualTo: 'Campervan')
        .get();

    final List<Admin> admin = dataQuery.docs
        .map<Admin>((e) => AdminModel.fromDocumentSnapshot(e).toEntity())
        .toList();
    return admin;
  }
}
