import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_joseantonioreyes/providers/ui_provider.dart';
import 'package:qr_scan_joseantonioreyes/screens/home_screen.dart';
import 'package:qr_scan_joseantonioreyes/screens/mapa_screen.dart';

void main() => runApp(MultiProvider(
  providers: [ChangeNotifierProvider(create: (_) => UIProvider())],
  child: MyApp(),
  ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'mapa': (_) => MapaScreen(),
      },
      theme: ThemeData(
        // No es pot emprar colorPrimary des de l'actualització de Flutter
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.deepPurple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
