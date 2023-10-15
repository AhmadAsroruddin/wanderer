import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/domain/usecase/addToAdmin.dart';

import '../../domain/entities/admin.dart';

class AdminCubit extends Cubit<AdminModel> {
  final AddToAdmin addToAdminUseCase;
  AdminCubit(this.addToAdminUseCase)
      : super(
          const AdminModel(
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
              markerId: ''),
        );

  Future<String> addToAdmin(Admin admin) async {
    final result = await addToAdminUseCase.execute(admin);

    return result;
  }

  void setName(String name) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setNoRek(String noRek) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setAddress(String address) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setEmail(String email) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setImage(List<dynamic> images) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setNoTelp(String noTelp) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setMarkerId(String markerId) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: markerId),
    );
  }

  void setInstagram(String instagram) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setWebsite(String website) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setTiktok(String tiktok) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
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
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setTime(String time) {
    final currState = state;

    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setDescription(String description) {
    final currState = state;
    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setCategory(String category) {
    final currState = state;
    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  void setLatLng(double lat, double lon) {
    final currState = state;
    emit(
      AdminModel(
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
          markerId: currState.markerId),
    );
  }

  String getCategory() {
    return state.category;
  }

  AdminModel getAllAdmin() {
    final currState = state;
    return AdminModel(
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
        markerId: currState.markerId);
  }
}
