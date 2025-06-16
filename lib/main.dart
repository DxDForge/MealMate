// main.dart - UPDATED VERSION
import 'package:flutter/material.dart';
import 'package:meal_mate/provider/auth_provider.dart';
import 'package:meal_mate/provider/finance_provider.dart';
import 'package:meal_mate/provider/group_provider.dart';
import 'package:meal_mate/provider/meal_provider.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Comment out Firebase for now - can add later
  // await Firebase.initializeApp();
  runApp(MealMateApp());
}

class MealMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => FinanceProvider()),
      ],
      child: MaterialApp(
        title: 'MealMate',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color(0xFF2E7D32),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
