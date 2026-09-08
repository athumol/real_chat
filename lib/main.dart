import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:real_chat/features/auth/presentation/auth_gate.dart';
//import 'package:real_chat/core/theme/app_theme.dart';
//import 'package:real_chat/features/auth/presentation/screens/auth/login_screen.dart';

import 'package:real_chat/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Chat',
      home: const AuthGate(),
    );
  }
}
