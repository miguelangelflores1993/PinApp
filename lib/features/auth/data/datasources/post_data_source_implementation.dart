import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:miguel/core/usecases/usecase.dart';
import 'package:miguel/features/auth/data/datasources/post_data_source.dart';
import 'package:miguel/features/auth/data/models/comments_model.dart';
import 'package:miguel/features/auth/data/models/post_model.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_comments.dart';
import 'package:networking_flutter_dio/core/helper/typedefs.dart';
import 'package:networking_flutter_dio/core/networking/api_config.dart';

class PostDataSourceImplementation extends PostRemoteDataSource {
  PostDataSourceImplementation({required this.api});

  final ApiRest api;
  static const MethodChannel _channel = MethodChannel('comments_channel');

  @override
  Future<List<PostModel>> getAllPost({required NoParams params}) async {
    final userData = await api.instance.getCollectionData<PostModel>(
      endpoint: '/posts',
      requiresAuthToken: false,
      converter: PostModel.fromJson,
    );
    return userData;
  }

  @override
  Future<List<CommentsModel>> getAllComments({
    required ParamsGetAllCommentsWithPostId params,
  }) async {
    final response = await _channel.invokeMethod<List<dynamic>>(
      'getComments',
      params.toJson(),
    );
    final encode = json.encode(response);
    final decode = json.decode(encode);
    return (decode as List)
        .map((e) => CommentsModel.fromJson(e as JSON))
        .toList();
  }
}
