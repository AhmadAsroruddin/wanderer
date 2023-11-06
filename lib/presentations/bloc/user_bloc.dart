import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/domain/usecase/getUserData.dart';
import 'package:wanderer/domain/usecase/updateUser.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserData _getUserData;
  final UpdateUser _updateUser;

  UserCubit(this._getUserData, this._updateUser) : super(UserLoading());

  Future<void> getUser() async {
    final result = await _getUserData.execute();

    result.fold(
      (l) => emit(UserFailed(error: l)),
      (r) => emit(UserSuccess(user: r)),
    );
  }

  Future<void> updateUserData(UserModel userModel) async {
    _updateUser.execute(userModel);
  }
}
