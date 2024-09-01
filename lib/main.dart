import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/config/injection_container.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DependencyInjectionInit().registerSingletons();
  runApp(const MyApp());
}