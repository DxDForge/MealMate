
// providers/meal_provider.dart
import 'package:flutter/material.dart';
import 'package:meal_mate/shared/models/meal_model.dart';

class MealProvider with ChangeNotifier {
  List<Meal> _meals = [];
  bool _isLoading = false;

  List<Meal> get meals => _meals;
  List<Meal> get todaysMeals {
    final today = DateTime.now();
    return _meals.where((meal) => 
      meal.date.year == today.year &&
      meal.date.month == today.month &&
      meal.date.day == today.day
    ).toList();
  }
  bool get isLoading => _isLoading;

  Future<void> loadMeals(String groupId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    // Generate sample meals for today
    final today = DateTime.now();
    _meals = [
      Meal(
        id: 'meal_1',
        groupId: groupId,
        date: today.copyWith(hour: 13, minute: 0),
        type: 'lunch',
        status: 'ready',
        ingredients: ['Rice', 'Dal', 'Vegetables'],
        cost: 45.0,
        cookId: 'cook_1',
        notes: 'Simple lunch',
      ),
      Meal(
        id: 'meal_2',
        groupId: groupId,
        date: today.copyWith(hour: 20, minute: 0),
        type: 'dinner',
        status: 'cooking',
        ingredients: ['Rice', 'Fish', 'Vegetables'],
        cost: 55.0,
        cookId: 'cook_1',
        notes: 'Special dinner',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addMeal(Meal meal) async {
    _meals.add(meal);
    notifyListeners();
  }
}
