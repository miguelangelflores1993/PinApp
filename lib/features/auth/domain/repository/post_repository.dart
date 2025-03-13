import 'package:dartz/dartz.dart';
import 'package:miguel/core/usecases/usecase.dart';
import 'package:miguel/features/auth/domain/entities/comments_entity.dart';
import 'package:miguel/features/auth/domain/entities/post_entity.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_comments.dart';
import 'package:networking_flutter_dio/core/networking/custom_exception.dart';

abstract class PostRepository {
  Future<Either<CustomException, List<Post>>> getAllPost({
    required NoParams params,
  });

  Future<Either<CustomException, List<Comments>>> getAllComments({
    required ParamsGetAllCommentsWithPostId params,
  });
}
