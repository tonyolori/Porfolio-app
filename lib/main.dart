import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/loadingPage.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio CV',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple[800],
        scaffoldBackgroundColor: Color(0xFF0D1117),
        colorScheme: const ColorScheme.dark().copyWith(background: Color(0xFF0D1117)),
      ),
      home: LoadingPage(),
    );
  }
}
