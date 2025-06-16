
// screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:meal_mate/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../group/group_setup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Welcome to MealMate',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            
            if (!_otpSent) ...[
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixText: '+880 ',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendOtp,
                child: Text('Send OTP'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ] else ...[
              Text('OTP sent to +880${_phoneController.text}'),
              SizedBox(height: 20),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  border: OutlineInputBorder(),
                  hintText: 'Use 1234 for demo',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  return ElevatedButton(
                    onPressed: auth.isLoading ? null : _verifyOtp,
                    child: auth.isLoading 
                        ? CircularProgressIndicator()
                        : Text('Verify OTP'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _sendOtp() {
    if (_phoneController.text.isNotEmpty) {
      setState(() {
        _otpSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent! Use 1234 for demo')),
      );
    }
  }

  void _verifyOtp() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.login(_phoneController.text, _otpController.text);
    
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GroupSetupScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Try 1234')),
      );
    }
  }
}