import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miguel/core/config/environment.dart';
import 'package:miguel/core/config/init.dart';

class AppBootstrapper {
  const AppBootstrapper._();

  static Future<void> init({
    required Widget mainAppWidget,
    required ENV environment,
    required void Function(Widget) runApp,
  }) async {
    await AppInit().initializeApp(environment: environment);
    await _setupSentrySDK(runApp, mainAppWidget);
  }

  static Future<void> _setupSentrySDK(void Function(Widget) appRunner, Widget app) async {
    appRunner(app);
  }
}
