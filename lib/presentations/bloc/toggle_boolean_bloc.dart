// my_cubit.dart
import 'package:bloc/bloc.dart';

class BooleanCubit extends Cubit<bool> {
  BooleanCubit() : super(false); // Nilai awal boolean

  void toggleValue() {
    emit(!state); // Toggle nilai boolean
  }
}
