import 'package:flutter/material.dart';
import 'package:miguel/app_bootstrapper.dart';
import 'package:miguel/core/config/environment.dart';
import 'package:miguel/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrapper.init(
    environment: ENV.local,
    mainAppWidget: const MyApp(),
    runApp: runApp,
  );
}
