import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:wanderer/data/datasource/admin_datasource.dart';
import 'package:wanderer/data/datasource/article_datasource.dart';
import 'package:wanderer/data/datasource/auth_datasource.dart';
import 'package:wanderer/data/datasource/comment_datasource.dart';
import 'package:wanderer/data/datasource/favorite_datasource.dart';
import 'package:wanderer/data/datasource/markers_datasource.dart';
import 'package:wanderer/data/datasource/order_datasource.dart';
import 'package:wanderer/data/datasource/owner_datasource.dart';
import 'package:wanderer/data/datasource/payout_datasource.dart';
import 'package:wanderer/data/datasource/user_datasource.dart';
import 'package:wanderer/data/service/admin_repos_impl.dart';
import 'package:wanderer/data/service/article_repos_impl.dart';
import 'package:wanderer/data/service/auth_repos_impl.dart';
import 'package:wanderer/data/service/comment_repos_impl.dart';
import 'package:wanderer/data/service/favorite_repos_impl.dart';
import 'package:wanderer/data/service/image_repos_implementation.dart';
import 'package:wanderer/data/service/location_data_repos_implementation.dart';
import 'package:wanderer/data/service/markers_repos_implementation.dart';
import 'package:wanderer/data/service/order_repos_impl.dart';
import 'package:wanderer/data/service/owner_repos_impl.dart';
import 'package:wanderer/data/service/payment_repos_impl.dart';
import 'package:wanderer/data/service/user_repos_impl.dart';
import 'package:wanderer/domain/repositories/admin_repository.dart';
import 'package:wanderer/domain/repositories/article_repository.dart';
import 'package:wanderer/domain/repositories/auth_repository.dart';
import 'package:wanderer/domain/repositories/comment_repository.dart';
import 'package:wanderer/domain/repositories/favorite_repository.dart';
import 'package:wanderer/domain/repositories/image_repository.dart';
import 'package:wanderer/domain/repositories/location_data_repository.dart';
import 'package:wanderer/domain/repositories/marker_repository.dart';
import 'package:wanderer/domain/repositories/order_repository.dart';
import 'package:wanderer/domain/repositories/owner_reposiroty.dart';
import 'package:wanderer/domain/repositories/payment_repository.dart';
import 'package:wanderer/domain/repositories/payout_repository.dart';
import 'package:wanderer/domain/repositories/user_repository.dart';
import 'package:wanderer/domain/usecase/addMarker.dart';
import 'package:wanderer/domain/usecase/addMarkerAdmin.dart';
import 'package:wanderer/domain/usecase/addOwner.dart';
import 'package:wanderer/domain/usecase/addToAdmin.dart';
import 'package:wanderer/domain/usecase/addToFavorite.dart';
import 'package:wanderer/domain/usecase/addTypeToAdmin.dart';
import 'package:wanderer/domain/usecase/approve.dart';
import 'package:wanderer/domain/usecase/createAccount.dart';
import 'package:wanderer/domain/usecase/createBeneficaries.dart';
import 'package:wanderer/domain/usecase/createPayout.dart';
import 'package:wanderer/domain/usecase/getAdmin.dart';
import 'package:wanderer/domain/usecase/getAdminCampervan.dart';
import 'package:wanderer/domain/usecase/getAllComments.dart';
import 'package:wanderer/domain/usecase/getAllFavorites.dart';
import 'package:wanderer/domain/usecase/getAllMarkers.dart';
import 'package:wanderer/domain/usecase/getAllTypes.dart';
import 'package:wanderer/domain/usecase/getArticleUrl.dart';
import 'package:wanderer/domain/usecase/getCurrentUserId.dart';
import 'package:wanderer/domain/usecase/getMarkerData.dart';
import 'package:wanderer/domain/usecase/getOrderDataByStatus.dart';
import 'package:wanderer/domain/usecase/getPaymentUrl.dart';
import 'package:wanderer/domain/usecase/getTransactionResponse.dart';
import 'package:wanderer/domain/usecase/getUserData.dart';
import 'package:wanderer/domain/usecase/isFavorite.dart';
import 'package:wanderer/domain/usecase/isFirstTime.dart';
import 'package:wanderer/domain/usecase/login.dart';
import 'package:wanderer/domain/usecase/logout.dart';
import 'package:wanderer/domain/usecase/pushComments.dart';
import 'package:wanderer/domain/usecase/removedFromFavorite.dart';
import 'package:wanderer/domain/usecase/report.dart';
import 'package:wanderer/domain/usecase/requestOrder.dart';
import 'package:wanderer/domain/usecase/resetPassword.dart';
import 'package:wanderer/domain/usecase/searcMarker.dart';
import 'package:wanderer/domain/usecase/setUserRoleToAdmin.dart';
import 'package:wanderer/domain/usecase/signInWithGoogle.dart';
import 'package:wanderer/domain/usecase/updateStatusOrder.dart';
import 'package:wanderer/domain/usecase/updateUser.dart';
import 'package:wanderer/domain/usecase/updateUserIdMarker.dart';
import 'package:wanderer/domain/usecase/uploadImages.dart';
import 'package:wanderer/domain/usecase/uploadOneImage.dart';
import 'package:wanderer/presentations/bloc/admin_bloc.dart';
import 'package:wanderer/presentations/bloc/admin_data_bloc.dart';
import 'package:wanderer/presentations/bloc/article_bloc.dart';
import 'package:wanderer/presentations/bloc/auth_bloc.dart';
import 'package:wanderer/presentations/bloc/comment_bloc.dart';
import 'package:wanderer/presentations/bloc/favorite_bloc.dart';
import 'package:wanderer/presentations/bloc/image_bloc.dart';
import 'package:wanderer/presentations/bloc/location_data_cubit.dart';
import 'package:wanderer/presentations/bloc/markers_bloc.dart';
import 'package:wanderer/presentations/bloc/order_bloc.dart';
import 'package:wanderer/presentations/bloc/payment_bloc.dart';
import 'package:wanderer/presentations/bloc/payout_bloc.dart';
import 'package:wanderer/presentations/bloc/router_bloc.dart';
import 'package:wanderer/presentations/bloc/user_bloc.dart';

import 'data/datasource/payment_datasource.dart';
import 'data/service/payout_repos_impl.dart';
import 'presentations/bloc/type_bloc.dart';

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
  locator.registerLazySingleton(() => AddToAdmin(adminRepos: locator()));
  locator.registerLazySingleton(() => AddTypeToAdmin(adminRepos: locator()));
  locator.registerLazySingleton(() => AddMarkerAdmin(markerRepos: locator()));
  locator.registerLazySingleton(() => GetAdmin(adminRepos: locator()));
  locator.registerLazySingleton(() => GetAllTypes(adminRepos: locator()));
  locator
      .registerLazySingleton(() => UpdateUseridMarker(markerRepos: locator()));
  locator.registerLazySingleton(() => GetCurrentUserId(authRepos: locator()));
  locator.registerLazySingleton(() => GetUserData(userRepository: locator()));
  locator
      .registerLazySingleton(() => SetUserRoleToAdmin(adminRepos: locator()));
  locator.registerLazySingleton(() => RequestOrder(orderRepos: locator()));
  locator
      .registerLazySingleton(() => GetOrderDataByStatus(orderRepos: locator()));
  locator.registerLazySingleton(() => UpdateStatusOrder(orderRepos: locator()));
  locator.registerLazySingleton(() => GetPaymentUrl(repos: locator()));
  locator.registerLazySingleton(
      () => GetTransactionResponse(paymentRepos: locator()));
  locator.registerLazySingleton(() => GetAdminCampervan(adminRepos: locator()));
  locator.registerLazySingleton(() => GetMarkerData(markerRepos: locator()));
  locator.registerLazySingleton(() => GetArticleUrl(articleRepos: locator()));
  locator.registerLazySingleton(() => SearchMarker(markerRepos: locator()));
  locator.registerLazySingleton(() => UpdateUser(userRepository: locator()));
  locator.registerLazySingleton(() => AddReport(userRepos: locator()));
  locator.registerLazySingleton(() => UploadOneImages(imageRepos: locator()));
  locator.registerLazySingleton(() => AddOwner(ownerRepository: locator()));
  locator
      .registerLazySingleton(() => CreateBeneficaries(payoutRepos: locator()));
  locator.registerLazySingleton(() => CreatePayout(payoutRepos: locator()));
  locator.registerLazySingleton(() => Approve(payoutRepos: locator()));

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
  locator.registerLazySingleton<AdminRepos>(
      () => AdminReposImpl(adminDataSource: locator()));
  locator.registerLazySingleton<UserRepository>(
      () => UserReposImpl(userDataSource: locator()));
  locator.registerLazySingleton<OrderRepos>(
      () => OrderReposImpl(orderDataSource: locator()));
  locator.registerLazySingleton<PaymentRepos>(
      () => PaymentReposImpl(paymentDataSource: locator()));
  locator.registerLazySingleton<ArticleRepos>(
      () => ArticleReposImpl(articleDataSource: locator()));
  locator.registerLazySingleton<OwnerRepository>(
      () => OwnerReposImpl(ownerDataSource: locator()));
  locator.registerLazySingleton<PayoutRepos>(
      () => PayoutReposImpl(payoutDatasource: locator()));

  //BLOC
  locator.registerFactory(() => AuthCubit(
      locator(), locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => RouterCubit(
        authUseCase: locator(),
        firstTimeDone: locator(),
      ));
  locator.registerFactory(() => LocationDataCubit(locator()));
  locator.registerFactory(() => MarkersCubit(
      locator(), locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => CommentCubit(locator(), locator()));
  locator.registerFactory(
      () => FavoriteCubit(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => ImageCubit(locator(), locator()));
  locator.registerFactory(() => AdminCubit(locator(), locator(), locator()));
  locator.registerFactory(() => TypeCubit(locator()));
  locator.registerFactory(
      () => AdminDataCubit(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => TypeCubitData(locator()));
  locator.registerFactory(() => UserCubit(locator(), locator(), locator()));
  locator.registerFactory(() => OrderCubit(locator(), locator(), locator()));
  locator.registerFactory(() => PaymentCubit(locator(), locator()));
  locator.registerFactory(() => ArticleCubit(locator()));
  locator.registerFactory(() => PayoutCubit(locator(), locator(), locator()));

  //DATA

  locator.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  locator
      .registerLazySingleton<MarkersDataSource>(() => MarkersDatasourceImpl());
  locator
      .registerLazySingleton<CommentDataSource>(() => CommentDataSourceImpl());
  locator.registerLazySingleton<FavoriteDataSource>(
      () => FavoriteDataSourceImpl());
  locator.registerLazySingleton<AdminDataSource>(() => AdminDataSourceImpl());
  locator.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl());
  locator.registerLazySingleton<OrderDataSource>(() => OrderDataSourceImpl());
  locator.registerLazySingleton<PaymentDataSource>(
      () => PaymentDataSourceImpl(dio: Dio()));
  locator
      .registerLazySingleton<ArticleDataSource>(() => ArticleDataSourceImpl());
  locator.registerLazySingleton<OwnerDataSource>(() => OwnerDataSourceImpl());
  locator.registerLazySingleton<PayoutDatasource>(
      () => PayoutDatasourceImpl(dio: Dio()));

  //ROUTER

  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseAuth.instance);
}
