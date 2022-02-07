import 'package:flutter/material.dart';
import 'package:garden_app/config/garden_app.dart';
import 'package:garden_app/config/injection.dart';

import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(AppEnviroments.prod.name);
  await getIt.allReady();
  runApp(const GardenApp());
}
