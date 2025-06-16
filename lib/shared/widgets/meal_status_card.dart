
// widgets/meal_status_card.dart
import 'package:flutter/material.dart';

class MealStatusCard extends StatelessWidget {
  final String mealType;
  final String status;
  final String time;
  final double cost;
  
  const MealStatusCard({
    Key? key,
    required this.mealType,
    required this.status,
    required this.time,
    required this.cost,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(status);
    
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor,
          child: Icon(
            _getMealIcon(mealType),
            color: Colors.white,
          ),
        ),
        title: Text(mealType),
        subtitle: Text('$time • ৳${cost.toStringAsFixed(0)}'),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        onTap: () => _showMealDetails(context),
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ready':
        return Colors.green;
      case 'cooking':
        return Colors.orange;
      case 'planned':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
  
  IconData _getMealIcon(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      default:
        return Icons.restaurant;
    }
  }
  
  void _showMealDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$mealType Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.schedule),
                SizedBox(width: 8),
                Text('Time: $time'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.attach_money),
                SizedBox(width: 8),
                Text('Cost: ৳${cost.toStringAsFixed(0)}'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info),
                SizedBox(width: 8),
                Text('Status: $status'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
