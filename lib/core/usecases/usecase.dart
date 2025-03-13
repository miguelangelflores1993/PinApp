import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:networking_flutter_dio/core/networking/custom_exception.dart';

abstract class UseCase<Type, Params> {
  Future<Either<CustomException, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
