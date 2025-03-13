import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserConfig {
  factory UserConfig() {
    return _instance;
  }

  UserConfig._internal();
  static final UserConfig _instance = UserConfig._internal();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String deviceUuid = '';

  String deviceMac = '';
  int deviceKey = 0;

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }

  Future<String?> getToken() async {
    final read = await secureStorage.read(
      key: 'get-token',
    );
    return read;
  }

  Future<void> saveToStorageMac(String mac) async {
    await secureStorage.write(key: 'mac', value: mac);
    deviceMac = mac;
  }

  Future<void> saveToStorageUuid(String uuid) async {
    await secureStorage.write(key: 'uuid', value: uuid);
    deviceUuid = uuid;
  }
}
