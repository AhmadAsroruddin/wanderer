import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/usecase/getCurrentUserId.dart';

import 'package:wanderer/domain/usecase/login.dart';
import 'package:wanderer/domain/usecase/logout.dart';
import 'package:wanderer/domain/usecase/resetPassword.dart';
import 'package:wanderer/domain/usecase/signInWithGoogle.dart';
import '../../domain/usecase/createAccount.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateAccount _createAccount;
  final Login _login;
  final Logout _logout;
  final SignInWithGoogle _signInWithGoogle;
  final ResetPassword _resetPassword;
  final GetCurrentUserId _getCurrentUserId;

  AuthCubit(this._getCurrentUserId, this._createAccount, this._login,
      this._logout, this._signInWithGoogle, this._resetPassword)
      : super(AuthInitial());

  Future<void> createAccount(String username, String email, String password,
      String telponNumber) async {
    emit(AuthLoading());
    final result =
        await _createAccount.execute(username, email, password, telponNumber);
    result.fold((l) {
      emit(AuthError(error: l));
    }, (r) {
      emit(AuthData(message: r));
    });
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await _login.execute(email, password);
    result.fold(
      (l) => emit(AuthError(error: l)),
      (r) => emit(
        AuthLogin(message: r),
      ),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _logout.execute();

    result.fold(
      (l) => emit(AuthError(error: l)),
      (r) => emit(
        AuthData(message: r),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await _signInWithGoogle.execute();

    result.fold(
      (l) => emit(
        AuthError(error: l),
      ),
      (r) => emit(
        AuthLogin(message: r),
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    final result = await _resetPassword.execute(email);

    result.fold(
      (l) => emit(
        AuthError(error: l),
      ),
      (r) => emit(
        ResetSended(message: r),
      ),
    );
  }

  Future<String> getCurrentUser() async {
    final id = await _getCurrentUserId.execute();
    return id;
  }
}
