import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/usecase/getAdmin.dart';
import 'package:wanderer/domain/usecase/getAdminCampervan.dart';
import 'package:wanderer/domain/usecase/getAllTypes.dart';

import '../../domain/entities/tipe.dart';

part 'admin_data_state.dart';

class AdminDataCubit extends Cubit<AdminDataState> {
  GetAdmin getAdmin;
  GetAllTypes getAllTypes;
  GetAdminCampervan getAdminCampervan;

  AdminDataCubit(this.getAdmin, this.getAllTypes, this.getAdminCampervan)
      : super(AdminDataInitial());

  Future<void> getAdminData(String markerId) async {
    emit(AdminDataLoading());
    final result = await getAdmin.execute(markerId);

    emit(AdminDataSuccess(data: result));
  }

  Future<void> getAllAdminCampervan() async {
    emit(AdminDataLoading());
    final result = await getAdminCampervan.execute();

    result.fold(
      (l) => {emit(AdminDataFailed(error: l))},
      (r) => {emit(AdminDataCampervan(campervan: r))},
    );
  }
}
