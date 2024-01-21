import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/data/models/report_model.dart';
import 'package:wanderer/data/models/user_model.dart';
import 'package:wanderer/domain/entities/user.dart';
import 'package:wanderer/domain/usecase/getUserData.dart';
import 'package:wanderer/domain/usecase/report.dart';
import 'package:wanderer/domain/usecase/updateUser.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserData _getUserData;
  final UpdateUser _updateUser;
  final AddReport _report;

  UserCubit(this._getUserData, this._updateUser, this._report)
      : super(UserLoading());

  Future<void> getUser(String uid) async {
    final result = await _getUserData.execute(uid);

    result.fold(
      (l) => emit(UserFailed(error: l)),
      (r) => emit(UserSuccess(user: r)),
    );
  }

  Future<Users> getUserReturn(String uid) async {
    final result = await _getUserData.execute(uid);
    Users userData = const Users(
        username: "",
        email: "",
        imageUrl: "",
        telponNumber: "",
        markers: [],
        role: "",
        token: "");
    result.fold(
      (l) {},
      (r) {
        userData = Users(
            username: r.username,
            email: r.email,
            imageUrl: r.imageUrl,
            telponNumber: r.telponNumber,
            markers: r.markers,
            role: r.role,
            token: r.token);
      },
    );
    return userData;
  }

  Future<void> updateUserData(UserModel userModel) async {
    _updateUser.execute(userModel);
  }

  Future<void> report(ReportModel reportModel) async {
    await _report.execute(reportModel);
  }
}
