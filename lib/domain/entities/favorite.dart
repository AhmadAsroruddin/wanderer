import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  const Favorite({required this.markerId});

  final String markerId;

  @override
  List<Object> get props => [markerId];
}
