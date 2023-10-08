import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:wanderer/data/datasource/auth_datasource.dart';
import 'package:wanderer/data/datasource/comment_datasource.dart';
import 'package:wanderer/data/datasource/favorite_datasource.dart';
import 'package:wanderer/data/datasource/markers_datasource.dart';
import 'package:wanderer/data/service/auth_repos_impl.dart';
import 'package:wanderer/data/service/comment_repos_impl.dart';
import 'package:wanderer/data/service/favorite_repos_impl.dart';
import 'package:wanderer/data/service/image_repos_implementation.dart';
import 'package:wanderer/data/service/location_data_repos_implementation.dart';
import 'package:wanderer/data/service/markers_repos_implementation.dart';
import 'package:wanderer/domain/repositories/auth_repository.dart';
import 'package:wanderer/domain/repositories/comment_repository.dart';
import 'package:wanderer/domain/repositories/favorite_repository.dart';
import 'package:wanderer/domain/repositories/image_repository.dart';
import 'package:wanderer/domain/repositories/location_data_repository.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';
import 'package:wanderer/domain/usecase/addMarker.dart';
import 'package:wanderer/domain/usecase/addToFavorite.dart';
import 'package:wanderer/domain/usecase/createAccount.dart';
import 'package:wanderer/domain/usecase/getAllComments.dart';
import 'package:wanderer/domain/usecase/getAllFavorites.dart';
import 'package:wanderer/domain/usecase/getAllMarkers.dart';
import 'package:wanderer/domain/usecase/isFavorite.dart';
import 'package:wanderer/domain/usecase/isFirstTime.dart';
import 'package:wanderer/domain/usecase/login.dart';
import 'package:wanderer/domain/usecase/logout.dart';
import 'package:wanderer/domain/usecase/pushComments.dart';
import 'package:wanderer/domain/usecase/removedFromFavorite.dart';
import 'package:wanderer/domain/usecase/resetPassword.dart';
import 'package:wanderer/domain/usecase/signInWithGoogle.dart';
import 'package:wanderer/domain/usecase/uploadImages.dart';
import 'package:wanderer/presentations/bloc/auth_bloc.dart';
import 'package:wanderer/presentations/bloc/comment_bloc.dart';
import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/bloc/router_bloc.dart';

final locator = GetIt.instance;

void init() {
  //USECASE
  locator.registerLazySingleton(() => CreateAccount(authRepos: locator()));
  locator.registerLazySingleton(() => Login(authRepos: locator()));
  locator.registerLazySingleton(() => Logout(authRepos: locator()));
  locator.registerLazySingleton(() => SignInWithGoogle(authRepos: locator()));
  locator.registerLazySingleton(() => ResetPassword(authRepos: locator()));
  locator.registerLazySingleton(() => IsFirstTime(authRepos: locator()));
  locator.registerLazySingleton(() => AddMarkers(markerRepos: locator()));
  locator.registerLazySingleton(() => UploadImages(imageRepos: locator()));
  locator.registerLazySingleton(() => GetAllMarkers(markerRepos: locator()));
  locator.registerLazySingleton(() => PushComment(commentRepos: locator()));
  locator.registerLazySingleton(() => GetAllComments(commentRepos: locator()));
  locator.registerLazySingleton(() => AddToFavorite(favoriteRepos: locator()));
  locator.registerLazySingleton(() => IsFavorite(favoriteRepos: locator()));
  locator
      .registerLazySingleton(() => GetAllFavorites(favoriteRepos: locator()));
  locator.registerLazySingleton(
      () => RemoveFromFavorite(favoriteRepos: locator()));

  //REPOSITORY
  locator.registerLazySingleton<AuthRepos>(() => AuthReposImpl(
      dataSource: locator(), firebaseFirestore: FirebaseFirestore.instance));
  locator
      .registerLazySingleton<LocationDataRepos>(() => LocationDataReposImpl());

  locator.registerLazySingleton<ImageRepos>(() => ImageReposImpl());
  locator.registerLazySingleton<MarkerRepos>(() => MarkersReposImpl(
      markersDataSource: locator(), firebaseFirestore: locator()));
  locator.registerLazySingleton<CommentRepos>(
      () => CommentsReposImpl(commentDataSource: locator()));
  locator.registerLazySingleton<FavoriteRepos>(
      () => FavoriteReposImpl(favoriteDataSource: locator()));

  //BLOC
  locator.registerFactory(
      () => AuthCubit(locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => RouterCubit(
        authUseCase: locator(),
        firstTimeDone: locator(),
      ));
  locator.registerFactory(() => LocationDataCubit(locator()));
  locator.registerFactory(() => MarkersCubit(locator(), locator()));
  locator.registerFactory(() => CommentCubit(locator(), locator()));
  locator.registerFactory(
      () => FavoriteCubit(locator(), locator(), locator(), locator()));

  //DATA

  locator.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  locator
      .registerLazySingleton<MarkersDataSource>(() => MarkersDatasourceImpl());
  locator
      .registerLazySingleton<CommentDataSource>(() => CommentDataSourceImpl());
  locator.registerLazySingleton<FavoriteDataSource>(
      () => FavoriteDataSourceImpl());

  //ROUTER

  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
