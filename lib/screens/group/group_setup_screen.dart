

// screens/group/group_setup_screen.dart
import 'package:flutter/material.dart';
import 'package:meal_mate/provider/auth_provider.dart';
import 'package:meal_mate/provider/group_provider.dart';
import 'package:meal_mate/screens/home_screen.dart';
import 'package:provider/provider.dart';


class GroupSetupScreen extends StatefulWidget {
  @override
  _GroupSetupScreenState createState() => _GroupSetupScreenState();
}

class _GroupSetupScreenState extends State<GroupSetupScreen> {
  final _groupNameController = TextEditingController();
  final _groupCodeController = TextEditingController();
  bool _isCreatingGroup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setup Group')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _isCreatingGroup = true),
                    child: Text('Create Group'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isCreatingGroup ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _isCreatingGroup = false),
                    child: Text('Join Group'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_isCreatingGroup ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            
            if (_isCreatingGroup) ...[
              TextField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter group name',
                ),
              ),
              SizedBox(height: 20),
              Consumer<GroupProvider>(
                builder: (context, groupProvider, child) {
                  return ElevatedButton(
                    onPressed: groupProvider.isLoading ? null : _createGroup,
                    child: groupProvider.isLoading 
                        ? CircularProgressIndicator()
                        : Text('Create Group'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  );
                },
              ),
            ] else ...[
              TextField(
                controller: _groupCodeController,
                decoration: InputDecoration(
                  labelText: 'Group Code',
                  border: OutlineInputBorder(),
                  hintText: 'Enter 6-digit group code',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Consumer<GroupProvider>(
                builder: (context, groupProvider, child) {
                  return ElevatedButton(
                    onPressed: groupProvider.isLoading ? null : _joinGroup,
                    child: groupProvider.isLoading 
                        ? CircularProgressIndicator()
                        : Text('Join Group'),
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

  void _createGroup() async {
    if (_groupNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter group name')),
      );
      return;
    }

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    
    final success = await groupProvider.createGroup(
      _groupNameController.text,
      auth.userId!,
    );

    if (success) {
      _navigateToHome();
    }
  }

  void _joinGroup() async {
    if (_groupCodeController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid 6-digit code')),
      );
      return;
    }

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    
    final success = await groupProvider.joinGroup(
      _groupCodeController.text,
      auth.userId!,
    );

    if (success) {
      _navigateToHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid group code')),
      );
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
