// providers/group_provider.dart
import 'package:flutter/material.dart';
import 'package:meal_mate/core/themes/group_model.dart';

class GroupProvider with ChangeNotifier {
  Group? _currentGroup;
  List<Group> _userGroups = [];
  bool _isLoading = false;

  Group? get currentGroup => _currentGroup;
  List<Group> get userGroups => _userGroups;
  bool get isLoading => _isLoading;

  Future<bool> createGroup(String name, String managerId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    final group = Group(
      id: 'group_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      code: _generateGroupCode(),
      createdAt: DateTime.now(),
      managerId: managerId,
      memberIds: [managerId],
      settings: {
        'mealsPerDay': 2,
        'currency': 'BDT',
        'monthlyBudget': 5000,
      },
    );

    _currentGroup = group;
    _userGroups.add(group);
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> joinGroup(String code, String userId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    // Simulate finding group by code
    if (code.length == 6) {
      final group = Group(
        id: 'group_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Test Group',
        code: code,
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        managerId: 'other_user',
        memberIds: ['other_user', userId],
        settings: {
          'mealsPerDay': 2,
          'currency': 'BDT',
          'monthlyBudget': 5000,
        },
      );

      _currentGroup = group;
      _userGroups.add(group);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  String _generateGroupCode() {
    return (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();
  }
}
