import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miguel/core/config/bloc_observer.dart';
import 'package:miguel/core/config/environment.dart';
import 'package:miguel/core/local/key_value_storage_service.dart';
import 'package:miguel/injection.dart';
import 'package:networking_flutter_dio/core/local/key_value_storage_base.dart';
import 'package:networking_flutter_dio/core/networking/api_config.dart';

class AppInit {
  KeyValueStorageService keyValueStorageService = KeyValueStorageService();
  Future<void> initializeApp({required ENV environment}) async {
    Bloc.observer = const AppBlocObserver();
    await initEnvironment(environment);
    await KeyValueStorageBase.init();
    await ApiRest.initialize(apiUrl: apiUrl, refreshTokenInterceptor: true);
    await init();
  }
}
