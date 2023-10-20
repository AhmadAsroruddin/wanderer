import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/admin.dart';
import 'package:wanderer/domain/usecase/getAdmin.dart';
import 'package:wanderer/domain/usecase/getAllTypes.dart';

import '../../domain/entities/tipe.dart';

part 'admin_data_state.dart';

class AdminDataCubit extends Cubit<AdminDataState> {
  GetAdmin getAdmin;
  GetAllTypes getAllTypes;

  AdminDataCubit(this.getAdmin, this.getAllTypes) : super(AdminDataLoading());

  Future<void> getAdminData(String markerId) async {
    final result = await getAdmin.execute(markerId);

    emit(AdminDataSuccess(data: result));
  }
}
