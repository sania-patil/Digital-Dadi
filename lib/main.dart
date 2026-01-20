import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/register_screen.dart';
import 'screens/home_before_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Dadi',
      theme: ThemeData(
        useMaterial3: true,

        // 🌸 Soft pastel emotional color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink.shade200,
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: Colors.white,

        // 🧡 Rounded buttons (Material 3 compliant)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          ),
        ),

        // 🧺 Soft rounded cards
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(12),
        ),

        // 📖 Large readable fonts (Hindi / Hinglish friendly)
        textTheme: GoogleFonts.poppinsTextTheme(
          const TextTheme(
            bodyLarge: TextStyle(fontSize: 18),
            bodyMedium: TextStyle(fontSize: 16),
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        shadowColor: Colors.grey.withOpacity(0.3),
      ),

      home: const HomeBeforeLogin(),
    );
  }
}

