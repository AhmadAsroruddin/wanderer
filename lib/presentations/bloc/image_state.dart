part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageFailed extends ImageState {
  final String error;
  const ImageFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class ImageSuccess extends ImageState {
  final List<String> message;
  const ImageSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
