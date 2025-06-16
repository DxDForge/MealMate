
// providers/finance_provider.dart
import 'package:flutter/material.dart';

class FinanceProvider with ChangeNotifier {
  double _totalFund = 2500.0;
  double _monthlyExpense = 1200.0;
  double _dailyExpense = 85.0;
  List<Map<String, dynamic>> _transactions = [];

  double get totalFund => _totalFund;
  double get monthlyExpense => _monthlyExpense;
  double get dailyExpense => _dailyExpense;
  List<Map<String, dynamic>> get transactions => _transactions;

  void addExpense(double amount, String description) {
    _totalFund -= amount;
    _monthlyExpense += amount;
    _dailyExpense += amount;
    
    _transactions.insert(0, {
      'type': 'expense',
      'amount': -amount,
      'description': description,
      'date': DateTime.now(),
    });
    
    notifyListeners();
  }

  void addContribution(double amount, String memberName) {
    _totalFund += amount;
    
    _transactions.insert(0, {
      'type': 'contribution',
      'amount': amount,
      'description': 'Contribution from $memberName',
      'date': DateTime.now(),
    });
    
    notifyListeners();
  }
}