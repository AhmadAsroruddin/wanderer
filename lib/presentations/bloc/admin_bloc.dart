import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/domain/usecase/addToAdmin.dart';
import 'package:wanderer/domain/usecase/getAdmin.dart';
import 'package:wanderer/domain/usecase/setUserRoleToAdmin.dart';

import '../../domain/entities/admin.dart';

class AdminCubit extends Cubit<Admin> {
  final AddToAdmin addToAdminUseCase;
  final GetAdmin getAdmin;
  final SetUserRoleToAdmin setRole;
  AdminCubit(this.addToAdminUseCase, this.getAdmin, this.setRole)
      : super(
          const Admin(
              id: '',
              userId: '',
              name: '',
              noRek: '',
              address: '',
              email: '',
              image: [],
              noTelp: '',
              tiktok: '',
              website: '',
              instagram: '',
              facilities: [],
              time: '',
              description: '',
              category: '',
              latitude: 0,
              longitude: 0,
              markerId: '',
              nameRek: "",
              bankRek: "",
              aliasNameRek: "",
              emailRek: ""),
        );

  Future<String> addToAdmin(Admin admin, String markerId) async {
    final result = await addToAdminUseCase.execute(admin, markerId);

    return result;
  }

  Future<void> updateUserRole(String userId, String adminId) async {
    await setRole.execute(userId, adminId);
  }

  Future<void> getAdminData(String markerId) async {
    final result = await getAdmin.execute(markerId);

    emit(result);
  }

  void setName(String name) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setNoRek(String noRek) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setAddress(String address) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setEmail(String email) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setImage(List<dynamic> images) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: images,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setNoTelp(String noTelp) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  Future<void> setMarkerId(String markerId) async {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setInstagram(String instagram) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setWebsite(String website) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setTiktok(String tiktok) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setFacilities(String facilities) {
    final currState = state;
    final newList = List<String>.from(currState.facilities);
    bool check = newList.contains(facilities);

    if (!check) {
      newList.add(facilities);
    } else {
      newList.remove(facilities);
    }

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: newList,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setTime(String time) {
    final currState = state;

    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setDescription(String description) {
    final currState = state;
    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setCategory(String category) {
    final currState = state;
    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setLatLng(double lat, double lon) {
    final currState = state;
    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: lat,
          longitude: lon,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setUserId(String userId) {
    final currState = state;
    emit(
      Admin(
          id: currState.id,
          userId: userId,
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: currState.nameRek,
          bankRek: currState.bankRek,
          aliasNameRek: currState.bankRek,
          emailRek: currState.emailRek),
    );
  }

  void setBank(BankAccount bankAccount) {
    final currState = state;
    emit(
      Admin(
          id: currState.id,
          userId: currState.userId,
          name: currState.name,
          noRek: bankAccount.account,
          address: currState.address,
          email: currState.email,
          description: currState.description,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
          time: currState.time,
          category: currState.category,
          latitude: currState.latitude,
          longitude: currState.longitude,
          markerId: currState.markerId,
          nameRek: bankAccount.name,
          bankRek: bankAccount.bank,
          aliasNameRek: bankAccount.aliasName,
          emailRek: bankAccount.email),
    );
  }

  String getCategory() {
    return state.category;
  }

  String setAdmin() {
    final currState = state;

    return currState.id;
  }

  Admin getAllAdmin() {
    final currState = state;
    return Admin(
      id: currState.id,
      userId: currState.userId,
      name: currState.name,
      noRek: currState.noRek,
      address: currState.address,
      email: currState.email,
      description: currState.description,
      image: currState.image,
      noTelp: currState.noTelp,
      instagram: currState.instagram,
      website: currState.website,
      tiktok: currState.tiktok,
      facilities: currState.facilities,
      time: currState.time,
      category: currState.category,
      latitude: currState.latitude,
      longitude: currState.longitude,
      markerId: currState.markerId,
      nameRek: currState.nameRek,
      bankRek: currState.bankRek,
      aliasNameRek: currState.bankRek,
      emailRek: currState.emailRek,
    );
  }
}
