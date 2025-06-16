
// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:meal_mate/core/themes/app_theme.dart';
import 'package:meal_mate/provider/finance_provider.dart';
import 'package:meal_mate/provider/group_provider.dart';
import 'package:meal_mate/shared/widgets/dashboard_card.dart';
import 'package:meal_mate/shared/widgets/meal_status_card.dart';
import 'package:meal_mate/shared/widgets/quick_action.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MealMate Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWelcomeSection(context),
            _buildDashboardCards(context),
            _buildTodaysMeals(context),
            _buildRecentActivity(context),
            SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: QuickActionsFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  
  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Your meal system is running smoothly',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.restaurant,
            color: Colors.white,
            size: 48,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDashboardCards(BuildContext context) {
    return Consumer2<GroupProvider, FinanceProvider>(
      builder: (context, groupProvider, financeProvider, child) {
        return Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Total Members',
                value: '${groupProvider.currentGroup?.memberIds.length ?? 0}',
                icon: Icons.people,
                color: AppTheme.primaryColor,
              ),
            ),
            Expanded(
              child: DashboardCard(
                title: 'This Month',
                value: '৳${financeProvider.monthlyExpense.toStringAsFixed(0)}',
                icon: Icons.account_balance_wallet,
                color: AppTheme.secondaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildTodaysMeals(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Today\'s Meals',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MealStatusCard(
          mealType: 'Lunch',
          status: 'Ready',
          time: '1:00 PM',
          cost: 45.0,
        ),
        MealStatusCard(
          mealType: 'Dinner',
          status: 'Cooking',
          time: '8:00 PM',
          cost: 55.0,
        ),
      ],
    );
  }
  
  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              child: Icon(Icons.shopping_cart, color: Colors.white),
            ),
            title: Text('Grocery shopping completed'),
            subtitle: Text('Rice, vegetables, and spices bought'),
            trailing: Text('2h ago'),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.secondaryColor,
              child: Icon(Icons.payment, color: Colors.white),
            ),
            title: Text('Member contribution received'),
            subtitle: Text('Karim added ৳500 to group fund'),
            trailing: Text('4h ago'),
          ),
        ),
      ],
    );
  }
  
  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notifications'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.warning, color: Colors.orange),
              title: Text('Low Fund Alert'),
              subtitle: Text('Group fund is running low'),
            ),
            ListTile(
              leading: Icon(Icons.schedule, color: Colors.blue),
              title: Text('Meal Reminder'),
              subtitle: Text('Lunch preparation starts in 2 hours'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}