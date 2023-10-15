import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/tipe.dart';
import 'package:wanderer/domain/usecase/addTypeToAdmin.dart';

class TypeCubit extends Cubit<List<Tipe>> {
  AddTypeToAdmin addTypeToAdmin;
  TypeCubit(this.addTypeToAdmin) : super([]);

  void setType(Tipe tipe) {
    final currState = state;
    final newList = List<Tipe>.from(currState);
    newList.add(tipe);
    emit(newList);
    print(newList);
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
