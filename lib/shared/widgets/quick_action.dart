
// widgets/quick_actions.dart
import 'package:flutter/material.dart';
import 'package:meal_mate/core/themes/app_theme.dart';

class QuickActionsFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showQuickActions(context),
      label: Text('Quick Actions'),
      icon: Icon(Icons.add),
      backgroundColor: AppTheme.primaryColor,
    );
  }
  
  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  'Add Expense',
                  Icons.add_circle,
                  Colors.red,
                  () => _addExpense(context),
                ),
                _buildActionButton(
                  context,
                  'Plan Meal',
                  Icons.restaurant_menu,
                  Colors.blue,
                  () => _planMeal(context),
                ),
                _buildActionButton(
                  context,
                  'Shopping',
                  Icons.shopping_cart,
                  Colors.green,
                  () => _goShopping(context),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  'Add Member',
                  Icons.person_add,
                  Colors.purple,
                  () => _addMember(context),
                ),
                _buildActionButton(
                  context,
                  'View Reports',
                  Icons.analytics,
                  Colors.orange,
                  () => _viewReports(context),
                ),
                _buildActionButton(
                  context,
                  'Settings',
                  Icons.settings,
                  Colors.grey,
                  () => _openSettings(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  void _addExpense(BuildContext context) {
    // Navigate to add expense screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add Expense feature coming soon!')),
    );
  }
  
  void _planMeal(BuildContext context) {
    // Navigate to meal planning screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meal Planning feature coming soon!')),
    );
  }
  
  void _goShopping(BuildContext context) {
    // Navigate to shopping list screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shopping List feature coming soon!')),
    );
  }
  
  void _addMember(BuildContext context) {
    // Navigate to add member screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add Member feature coming soon!')),
    );
  }
  
  void _viewReports(BuildContext context) {
    // Navigate to reports screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reports feature coming soon!')),
    );
  }
  
  void _openSettings(BuildContext context) {
    // Navigate to settings screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings feature coming soon!')),
    );
  }
}