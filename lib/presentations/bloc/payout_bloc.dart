import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/bankAccount.dart';
import 'package:wanderer/domain/usecase/approve.dart';
import 'package:wanderer/domain/usecase/createBeneficaries.dart';
import 'package:wanderer/domain/usecase/createPayout.dart';

part 'payout_state.dart';

class PayoutCubit extends Cubit<PayoutState> {
  CreateBeneficaries _createBeneficaries;
  CreatePayout createPayout;
  Approve approve;

  PayoutCubit(this._createBeneficaries, this.approve, this.createPayout)
      : super(PayoutInitial());

  Future<void> createBeneficaries(BankAccount bankAccount) async {
    emit(PayOutLoading());

    final response = await _createBeneficaries.execute(bankAccount);

    response.fold(
      (l) => emit(BeneficariesFailed(error: l)),
      (r) => emit(BeneficariesSuccess(message: r)),
    );
  }

  Future<void> approvePayout(String id) async {
    emit(PayOutLoading());
    final response = await approve.execute(id);

    response.fold(
      (l) => emit(BeneficariesFailed(error: l)),
      (r) => emit(ApproveSuccess(message: r)),
    );
  }

  Future<String> createPayoutBloc(
      BankAccount bankAccount, String amount, String notes) async {
    emit(PayOutLoading());

    final response = await createPayout.execute(bankAccount, amount, notes);

    return response;
  }
}
