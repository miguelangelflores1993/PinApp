import 'package:dartz/dartz.dart';
import 'package:miguel/core/usecases/usecase.dart';
import 'package:miguel/features/auth/domain/entities/comments_entity.dart';
import 'package:miguel/features/auth/domain/repository/post_repository.dart';
import 'package:networking_flutter_dio/core/networking/custom_exception.dart';

class GetAllCommentsByPostIdUseCase
    implements UseCase<List<Comments>, ParamsGetAllCommentsWithPostId> {
  GetAllCommentsByPostIdUseCase(this.repository);
  final PostRepository repository;

  @override
  Future<Either<CustomException, List<Comments>>> call(
    ParamsGetAllCommentsWithPostId params,
  ) {
    return repository.getAllComments(params: params);
  }
}

class ParamsGetAllCommentsWithPostId {
  const ParamsGetAllCommentsWithPostId({required this.postId});

  final int postId;

  Map<String, dynamic> toJson() {
    return {'postId': postId};
  }
}
