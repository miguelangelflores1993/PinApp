import 'package:miguel/core/usecases/usecase.dart';
import 'package:miguel/features/auth/data/models/comments_model.dart';
import 'package:miguel/features/auth/data/models/post_model.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_comments.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPost({required NoParams params});
  Future<List<CommentsModel>> getAllComments({
    required ParamsGetAllCommentsWithPostId params,
  });
}
