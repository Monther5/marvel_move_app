import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:marvel_app/pages/splash.dart';
import 'package:marvel_app/proveder/api_provider.dart';
import 'package:marvel_app/proveder/auth_provider.dart';
import 'package:marvel_app/proveder/baise_provider.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaiseProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()..getmoive()),
        ChangeNotifierProvider(
            create: (_) => AuthentProvider()..initilazAuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: false,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black)),
        ),
        home: const Splash(),
      ),
    );
  }
}