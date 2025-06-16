
// models/meal_model.dart
class Meal {
  final String id;
  final String groupId;
  final DateTime date;
  final String type; // breakfast, lunch, dinner
  final String status; // planned, cooked, served
  final List<String> ingredients;
  final double cost;
  final String? cookId;
  final String? notes;
  
  Meal({
    required this.id,
    required this.groupId,
    required this.date,
    required this.type,
    required this.status,
    required this.ingredients,
    required this.cost,
    this.cookId,
    this.notes,
  });
  
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      groupId: map['groupId'],
      date: DateTime.parse(map['date']),
      type: map['type'],
      status: map['status'],
      ingredients: List<String>.from(map['ingredients']),
      cost: map['cost'].toDouble(),
      cookId: map['cookId'],
      notes: map['notes'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'date': date.toIso8601String(),
      'type': type,
      'status': status,
      'ingredients': ingredients,
      'cost': cost,
      'cookId': cookId,
      'notes': notes,
    };
  }
}
