import 'package:bloc/bloc.dart';
import 'package:wanderer/domain/usecase/isFirstTime.dart';

import '../../domain/usecase/firstTimeDone.dart';

class RouterCubit extends Cubit<bool> {
  final IsFirstTime authUseCase;
  final FirstTimeDone firstTimeDone;

  RouterCubit({required this.authUseCase, required this.firstTimeDone})
      : super(false);

  Future<void> checkLoginStatus() async {
    emit(await authUseCase.execute());
  }

  Future<void> firstTimeFalse() async {
    emit(await firstTimeDone.execute());
  }
}
