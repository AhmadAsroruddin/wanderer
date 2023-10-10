import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/admin_model.dart';

class AdminCubit extends Cubit<AdminModel> {
  AdminCubit()
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
              markerId: ''),
        );

  void setName(String name) {
    final currState = state;

    emit(
      AdminModel(
          name: name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: images,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: website,
          tiktok: currState.tiktok,
          facilities: currState.facilities,
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
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: tiktok,
          facilities: currState.facilities,
          markerId: currState.markerId),
    );
  }

  void setFacilities(List<String> facilities) {
    final currState = state;

    emit(
      AdminModel(
          name: currState.name,
          noRek: currState.noRek,
          address: currState.address,
          email: currState.email,
          image: currState.image,
          noTelp: currState.noTelp,
          instagram: currState.instagram,
          website: currState.website,
          tiktok: currState.tiktok,
          facilities: facilities,
          markerId: currState.markerId),
    );
  }
}
