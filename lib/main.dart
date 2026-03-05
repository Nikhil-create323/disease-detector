import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

final kLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 30, 199, 108),
    onSecondary: Colors.green.shade400,
    primary: Colors.green.shade400,
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor:  Color.fromARGB(255, 31, 111, 35),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
);

final kDarkTheme = ThemeData.dark(
  useMaterial3: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    var brightness = ref.watch(themeProvider);
    return MaterialApp(
        // title: '',
        themeMode: ThemeMode.light,            
        theme: kDarkTheme,   
        // theme: brightness ? kDarkTheme : kLightTheme,
        home: const WelcomeScreen());
      
  }
}
