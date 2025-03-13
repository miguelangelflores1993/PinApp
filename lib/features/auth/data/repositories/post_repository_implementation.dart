import 'package:dartz/dartz.dart';
import 'package:miguel/core/usecases/usecase.dart';
import 'package:miguel/features/auth/data/datasources/post_data_source.dart';
import 'package:miguel/features/auth/domain/entities/comments_entity.dart';
import 'package:miguel/features/auth/domain/entities/post_entity.dart';
import 'package:miguel/features/auth/domain/repository/post_repository.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_comments.dart';
import 'package:networking_flutter_dio/core/networking/custom_exception.dart';

class PostRepositoryImplementation implements PostRepository {
  PostRepositoryImplementation({required this.postDataSource});

  final PostRemoteDataSource postDataSource;

  @override
  Future<Either<CustomException, List<Comments>>> getAllComments({
    required ParamsGetAllCommentsWithPostId params,
  }) async {
    try {
      final comments = await postDataSource.getAllComments(params: params);
      return Right(comments);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, List<Post>>> getAllPost({
    required NoParams params,
  }) async {
    try {
      final post = await postDataSource.getAllPost(params: params);
      return Right(post);
    } on CustomException catch (e) {
      return Left(e);
    }
  }
}
