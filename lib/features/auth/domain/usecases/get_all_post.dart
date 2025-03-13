import 'package:dartz/dartz.dart';
import 'package:miguel/core/usecases/usecase.dart';
import 'package:miguel/features/auth/domain/entities/post_entity.dart';
import 'package:miguel/features/auth/domain/repository/post_repository.dart';
import 'package:networking_flutter_dio/core/networking/custom_exception.dart';

class GetAllPostUseCase implements UseCase<List<Post>, NoParams> {
  GetAllPostUseCase(this.repository);
  final PostRepository repository;

  @override
  Future<Either<CustomException, List<Post>>> call(NoParams params) {
    return repository.getAllPost(params: params);
  }
}
