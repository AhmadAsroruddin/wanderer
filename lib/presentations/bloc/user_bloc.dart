import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/domain/usecase/getUserData.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  GetUserData _getUserData;

  UserCubit(this._getUserData) : super(UserLoading());

  Future<void> getUser() async {
    final result = await _getUserData.execute();

    result.fold(
      (l) => emit(UserFailed(error: l)),
      (r) => emit(UserSuccess(user: r)),
    );
  }
}
