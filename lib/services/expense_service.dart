import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/expense_model.dart';
import 'dart:math';

class ExpenseService {
  // Singleton pattern untuk memastikan hanya ada satu instance dari service ini
  static final ExpenseService _instance = ExpenseService._internal();
  factory ExpenseService() {
    return _instance;
  }
  ExpenseService._internal();

  // Daftar kategori yang tersedia
  final List<Category> _categories = [
    Category(id: 'c1', name: 'Makanan', icon: Icons.fastfood),
    Category(id: 'c2', name: 'Transportasi', icon: Icons.directions_car),
    Category(id: 'c3', name: 'Utilitas', icon: Icons.receipt_long),
    Category(id: 'c4', name: 'Hiburan', icon: Icons.movie),
    Category(id: 'c5', name: 'Pendidikan', icon: Icons.school),
  ];

  // Data awal pengeluaran
  final List<Expense> _expenses = [
    Expense(id: 'e1', title: 'Nasi Padang', description: 'Makan siang', amount: 25000, date: DateTime.now().subtract(const Duration(days: 1)), category: Category(id: 'c1', name: 'Makanan', icon: Icons.fastfood)),
    Expense(id: 'e2', title: 'Tiket Bioskop', description: 'Nonton film action', amount: 50000, date: DateTime.now().subtract(const Duration(days: 2)), category: Category(id: 'c4', name: 'Hiburan', icon: Icons.movie)),
    Expense(id: 'e3', title: 'Beli Buku Flutter', description: 'Di Gramedia', amount: 120000, date: DateTime.now().subtract(const Duration(days: 3)), category: Category(id: 'c5', name: 'Pendidikan', icon: Icons.school)),
  ];

  List<Category> getCategories() {
    return _categories;
  }

  List<Expense> getExpenses() {
    // Urutkan dari yang terbaru
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    return _expenses;
  }

  void addExpense(String title, String description, double amount, DateTime date, Category category) {
    final newExpense = Expense(
      id: 'e${Random().nextInt(1000)}', // ID acak sederhana
      title: title,
      description: description,
      amount: amount,
      date: date,
      category: category,
    );
    _expenses.add(newExpense);
  }

  void updateExpense(String id, String newTitle, String newDescription, double newAmount, DateTime newDate, Category newCategory) {
    final expenseIndex = _expenses.indexWhere((exp) => exp.id == id);
    if (expenseIndex != -1) {
      _expenses[expenseIndex] = Expense(
        id: id,
        title: newTitle,
        description: newDescription,
        amount: newAmount,
        date: newDate,
        category: newCategory,
      );
    }
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((exp) => exp.id == id);
  }
}
