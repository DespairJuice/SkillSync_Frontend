import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'providers/data_provider.dart';
import 'screens/splash_screen.dart';
import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('Main: Starting app initialization');

  // Initialize date formatting for Spanish locale
  await initializeDateFormatting('es', null);

  // Set the API base URL
  await ApiService.setBaseUrl('https://skillsync-backend-production-e390.up.railway.app');
  print('Main: API base URL set');

  runApp(const SkillSyncApp());
}

class SkillSyncApp extends StatefulWidget {
  const SkillSyncApp({super.key});

  @override
  State<SkillSyncApp> createState() => _SkillSyncAppState();
}

class _SkillSyncAppState extends State<SkillSyncApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
        title: 'SkillSync',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0A0A0F),
          primaryColor: const Color(0xFF00FFFF),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF00FFFF),
            secondary: Color(0xFF8A2BE2),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            titleLarge: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            labelLarge: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
            labelMedium: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
            labelSmall: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: const Color(0xFF1A1A2E),
            titleTextStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF1A1A2E),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.white70),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00FFFF)),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FFFF),
              foregroundColor: Colors.black,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF00FFFF),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
