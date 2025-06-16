// screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:meal_mate/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  _checkAuthStatus() async {
    await Future.delayed(Duration(seconds: 2));
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'MealMate',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Smart Meal Management',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}






// // Update the main.dart imports section:
// // Add these imports to main.dart:
// import 'screens/finance/add_expense_screen.dart';

// // Update the home_screen.dart quick actions:
// // In the _addExpense method, replace the snackbar with:
// void _addExpense(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => AddExpenseScreen()),
//   );
// }