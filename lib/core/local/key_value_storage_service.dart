import 'package:networking_flutter_dio/core/local/variables.dart';

class KeyValueStorageService {
  String get authTokenKey => GlobalVariables.authTokenKey;
  String get authTokenRefreshKey => GlobalVariables.authTokenRefreshKey;
  String get authUserKey => GlobalVariables.authUserKey;
}
