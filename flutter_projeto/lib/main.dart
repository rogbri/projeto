import 'package:flutter/material.dart';
import 'package:flutter_projeto/CalendarScreen.dart';
import 'package:flutter_projeto/HomeScreen.dart';
import 'package:flutter_projeto/RegisterScreen.dart';
import 'package:flutter_projeto/aboutScreen.dart';
import 'package:flutter_projeto/alarmScreen.dart';
import 'package:flutter_projeto/groceriesScreen.dart';
import 'package:flutter_projeto/loginScreen.dart';
import 'package:flutter_projeto/stopwatchScreen.dart';
import 'package:flutter_projeto/timerScreen.dart';


void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo alarme e variados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/alarm': (context) => const AlarmScreen(),
        '/stopwatch': (context) => const StopwatchScreen(),
        '/timer': (context) => const TimerScreen(),
        '/groceries': (context) => const GroceriesScreen(),
      },
    );
  }
}