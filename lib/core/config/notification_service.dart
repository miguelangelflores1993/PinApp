import 'package:flutter/services.dart';

class NotificationSettings {
  static const platform = MethodChannel('muv.mobi.lat.app/notification_settings');

  static Future<void> openNotificationSettings() async {
    try {
      await platform.invokeMethod('openNotificationSettings');
    } catch (e) {
      print("Error al abrir configuración de notificaciones: $e");
    }
  }
}
