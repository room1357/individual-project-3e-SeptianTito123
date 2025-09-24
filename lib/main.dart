import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Import halaman login sebagai halaman awal

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Flutter Terintegrasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        // (Opsional) Style global agar semua AppBar punya teks & ikon putih
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
        ),
      ),
      // Mulai aplikasi dari alur Login
      home: const LoginScreen(),
    );
  }
}
