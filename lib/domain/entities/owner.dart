import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final String name;
  final String nik;
  final String photoOnlyUrl;
  final String photoWithBodyUrl;

  Owner(
      {required this.name,
      required this.nik,
      required this.photoOnlyUrl,
      required this.photoWithBodyUrl});

  @override
  List<Object> get props => [name, nik, photoOnlyUrl, photoWithBodyUrl];
}
