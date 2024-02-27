import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/tipe_model.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/domain/usecase/addTypeToAdmin.dart';
import 'package:wanderer/domain/usecase/updateTipe.dart';

import '../../domain/usecase/getAllTypes.dart';

part 'type_data_state.dart';

class TypeCubit extends Cubit<List<Tipe>> {
  AddTypeToAdmin addTypeToAdmin;
  TypeCubit(this.addTypeToAdmin) : super([]);

  void setType(Tipe tipe) {
    final currState = state;
    final newList = List<Tipe>.from(currState);
    newList.add(tipe);
    emit(newList);
  }

  List<Tipe> getTipe() {
    return state;
  }

  Future<void> addType(List<Tipe> tipe, String adminId) async {
    for (var element in tipe) {
      await addTypeToAdmin.execute(element, adminId);
    }
  }
}

class TypeCubitData extends Cubit<TypeDataState> {
  GetAllTypes getAllTypes;
  UpdateTipe updateTipe;

  TypeCubitData(this.getAllTypes, this.updateTipe) : super(TypeDataLoading());

  Future<void> getType(String adminId) async {
    final result = await getAllTypes.execute(adminId);

    emit(TypeDataSuccessState(tipe: result));
  }

  Future<void> update(TipeModel tipe) async {
    await updateTipe.execute(tipe);
  }
}
