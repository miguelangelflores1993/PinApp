import 'package:get_it/get_it.dart';
import 'package:miguel/core/local/key_value_storage_service.dart';
import 'package:miguel/features/auth/data/datasources/post_data_source.dart';
import 'package:miguel/features/auth/data/datasources/post_data_source_implementation.dart';
import 'package:miguel/features/auth/data/repositories/post_repository_implementation.dart';
import 'package:miguel/features/auth/domain/repository/post_repository.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_comments.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_post.dart';
import 'package:miguel/features/auth/presenter/bloc/post_bloc.dart';
import 'package:networking_flutter_dio/core/networking/api_config.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl
    ..registerFactory(
      () => PostBloc(
        getAllCommentsByPostIdUseCase: sl(),
        getAllPostUseCase: sl(),
      ),
    )
    //USE CASES
    ..registerLazySingleton(() => GetAllCommentsByPostIdUseCase(sl()))
    ..registerLazySingleton(() => GetAllPostUseCase(sl()))
    //REPOSITORIES
    ..registerLazySingleton<PostRepository>(
      () => PostRepositoryImplementation(postDataSource: sl()),
    )
    //DATA SOURCES
    ..registerLazySingleton<PostRemoteDataSource>(
      () => PostDataSourceImplementation(api: sl()),
    )
    //EXTERNAL
    ..registerLazySingleton<ApiRest>(ApiRest.new)
    ..registerLazySingleton<KeyValueStorageService>(KeyValueStorageService.new);
}
