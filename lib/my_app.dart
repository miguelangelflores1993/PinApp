import 'package:flutter/material.dart';
import 'package:miguel/core/config/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Ueno Rides',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
    );
  }
}
