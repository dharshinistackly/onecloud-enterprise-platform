import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const OneCloudApp());
}

class OneCloudApp extends StatelessWidget {
  const OneCloudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OneCloud Enterprise Platform',

      initialRoute: AppRoutes.login,

      routes: AppRoutes.routes,
    );
  }
}