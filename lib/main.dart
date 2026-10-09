import 'package:flutter/material.dart';

import 'core/theme/diary_theme.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signedIn = false;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Щоденник велосипедиста',
    debugShowCheckedModeBanner: false,
    theme: diaryTheme(),
    home: signedIn
        ? HomeScreen(onLogout: () => setState(() => signedIn = false))
        : AuthScreen(onLogin: () => setState(() => signedIn = true)),
  );
}
