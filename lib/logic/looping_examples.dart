import '../models/category.dart';
import '../models/expense_model.dart';
import 'package:flutter/material.dart';

class LoopingExamples {
  // Definisikan kategori
  static final _makanan = Category(id: 'c1', name: 'Makanan', icon: Icons.fastfood);
  static final _transportasi = Category(id: 'c2', name: 'Transportasi', icon: Icons.directions_car);
  static final _hiburan = Category(id: 'c4', name: 'Hiburan', icon: Icons.movie);

  // --- PERBAIKAN: Gunakan objek Category, bukan String ---
  static List<Expense> expenses = [
    Expense(id: 'e1', title: 'Kopi Pagi', description: 'Espresso', amount: 25000, date: DateTime(2023, 10, 20), category: _makanan),
    Expense(id: 'e2', title: 'Bensin Motor', description: 'Isi Pertamax', amount: 30000, date: DateTime(2023, 10, 20), category: _transportasi),
    Expense(id: 'e3', title: 'Nasi Goreng', description: 'Makan malam', amount: 20000, date: DateTime(2023, 10, 21), category: _makanan),
    Expense(id: 'e4', title: 'Tiket Bioskop', description: 'Nonton film', amount: 50000, date: DateTime(2023, 10, 22), category: _hiburan),
  ];

  // (Fungsi calculateTotal... tidak perlu diubah)
  static double calculateTotalTraditional(List<Expense> expenses) { /* ... */ return 0;}
  static double calculateTotalForIn(List<Expense> expenses) { /* ... */ return 0;}
  static double calculateTotalForEach(List<Expense> expenses) { /* ... */ return 0;}
  static double calculateTotalFold(List<Expense> expenses) { /* ... */ return 0;}
  static double calculateTotalReduce(List<Expense> expenses) { /* ... */ return 0;}

  // (Fungsi findExpense... tidak perlu diubah)
  static Expense? findExpenseTraditional(List<Expense> expenses, String id) { /* ... */ return null;}
  static Expense? findExpenseWhere(List<Expense> expenses, String id) { /* ... */ return null;}

  static List<Expense> filterByCategoryManual(List<Expense> expenses, String category) {
    List<Expense> result = [];
    for (Expense expense in expenses) {
      // --- PERBAIKAN: Bandingkan dengan expense.category.name ---
      if (expense.category.name.toLowerCase() == category.toLowerCase()) {
        result.add(expense);
      }
    }
    return result;
  }

  static List<Expense> filterByCategoryWhere(List<Expense> expenses, String category) {
    // --- PERBAIKAN: Bandingkan dengan expense.category.name ---
    return expenses.where((expense) =>
      expense.category.name.toLowerCase() == category.toLowerCase()
    ).toList();
  }
}

