import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/admin_model.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/entities/owner.dart';
import 'package:wanderer/domain/usecase/addOwner.dart';
import 'package:wanderer/domain/usecase/getAdmin.dart';
import 'package:wanderer/domain/usecase/getAdminCampervan.dart';
import 'package:wanderer/domain/usecase/getAdminUser.dart';
import 'package:wanderer/domain/usecase/getAllTypes.dart';
import 'package:wanderer/domain/usecase/updateAdmin.dart';

import '../../domain/entities/tipe.dart';
import '../../domain/entities/user.dart';

part 'admin_data_state.dart';

class AdminDataCubit extends Cubit<AdminDataState> {
  GetAdmin getAdmin;
  GetAllTypes getAllTypes;
  GetAdminCampervan getAdminCampervan;
  AddOwner addOwnerUseCase;
  GetUserAdmin getUserAdminUsecase;
  AdminUpdate adminUpdate;

  AdminDataCubit(this.getAdmin, this.getAllTypes, this.getAdminCampervan,
      this.addOwnerUseCase, this.getUserAdminUsecase, this.adminUpdate)
      : super(AdminDataInitial());

  Future<void> getAdminData(String markerId) async {
    emit(AdminDataLoading());
    final result = await getAdmin.execute(markerId);

    emit(AdminDataSuccess(data: result));
  }

  Future<Admin> getAdminDataReturn(String markerId) async {
    emit(AdminDataLoading());
    final result = await getAdmin.execute(markerId);

    return result;
  }

  Future<void> getAllAdminCampervan(bool onSearch, String key) async {
    emit(AdminDataLoading());
    final result = await getAdminCampervan.execute(onSearch, key);

    result.fold(
      (l) => {emit(AdminDataFailed(error: l))},
      (r) => {emit(AdminDataCampervan(campervan: r))},
    );
  }

  Future<void> addOwner(Owner owner, String adminId) async {
    emit(AdminDataLoading());
    final result = await addOwnerUseCase.execute(owner, adminId);
    result.fold(
      (l) => emit(AdminDataFailed(error: l)),
      (r) => emit(OwnerSuccess(message: r)),
    );
  }

  Future<Users> getAdminUser(String adminId) async {
    final result = getUserAdminUsecase.execute(adminId);
    return result;
  }

  Future<void> updateData(AdminModel admin) async {
    await adminUpdate.execute(admin);
  }
}
