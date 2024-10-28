import 'package:education_app/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ShadApp.custom(
      appBuilder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Education App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        // Add this builder for ShadToaster support (if needed)
        builder: (context, child) {
          return ShadToaster(child: child!);
        },
      ),
    );
  }
}