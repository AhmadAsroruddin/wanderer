import 'package:equatable/equatable.dart';

class OwnerModel extends Equatable {
  final String name;
  final String nik;
  final String photoOnlyUrl;
  final String photoWithBodyUrl;

  OwnerModel(
      {required this.name,
      required this.nik,
      required this.photoOnlyUrl,
      required this.photoWithBodyUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nik': nik,
      'photoOnlyUrl': photoOnlyUrl,
      'photoWithBodyUrl': photoWithBodyUrl
    };
  }

  @override
  List<Object> get props => [name, nik, photoOnlyUrl, photoWithBodyUrl];
}
