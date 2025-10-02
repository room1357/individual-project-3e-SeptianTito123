import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/expense_model.dart';

class ExpenseManager {
  // Definisikan kategori yang bisa digunakan kembali
  static final _makanan = Category(id: 'c1', name: 'Makanan', icon: Icons.fastfood);
  static final _transportasi = Category(id: 'c2', name: 'Transportasi', icon: Icons.directions_car);
  static final _hiburan = Category(id: 'c4', name: 'Hiburan', icon: Icons.movie);
  static final _kebutuhan = Category(id: 'c6', name: 'Kebutuhan', icon: Icons.shopping_cart);

  // --- PERBAIKAN: Gunakan objek Category, bukan String ---
  static List<Expense> expenses = [
    Expense(id: 'em1', title: 'Kopi Pagi', description: 'Espresso di cafe', amount: 25000, date: DateTime(2023, 10, 20), category: _makanan),
    Expense(id: 'em2', title: 'Bensin Motor', description: 'Isi Pertamax', amount: 30000, date: DateTime(2023, 10, 20), category: _transportasi),
    Expense(id: 'em3', title: 'Nasi Goreng', description: 'Makan malam', amount: 20000, date: DateTime(2023, 10, 21), category: _makanan),
    Expense(id: 'em4', title: 'Tiket Bioskop', description: 'Nonton film baru', amount: 50000, date: DateTime(2023, 10, 22), category: _hiburan),
    Expense(id: 'em5', title: 'Belanja Bulanan', description: 'Sabun, sampo, dll', amount: 150000, date: DateTime(2023, 11, 1), category: _kebutuhan),
    Expense(id: 'em6', title: 'Paket Data', description: 'Kuota internet', amount: 75000, date: DateTime(2023, 11, 5), category: _kebutuhan),
    Expense(id: 'em7', title: 'Service Motor', description: 'Ganti oli rutin', amount: 80000, date: DateTime(2023, 11, 15), category: _transportasi),
    Expense(id: 'em8', title: 'Kopi Siang', description: 'Americano', amount: 22000, date: DateTime(2023, 11, 15), category: _makanan),
  ];

  static Map<String, double> getTotalByCategory(List<Expense> expenses) {
    Map<String, double> result = {};
    for (var expense in expenses) {
      // --- PERBAIKAN: Gunakan expense.category.name ---
      result[expense.category.name] = (result[expense.category.name] ?? 0) + expense.amount;
    }
    return result;
  }

  static Expense? getHighestExpense(List<Expense> expenses) {
    if (expenses.isEmpty) return null;
    return expenses.reduce((a, b) => a.amount > b.amount ? a : b);
  }

  static List<Expense> getExpensesByMonth(List<Expense> expenses, int month, int year) {
    return expenses.where((expense) =>
      expense.date.month == month && expense.date.year == year
    ).toList();
  }

  static List<Expense> searchExpenses(List<Expense> expenses, String keyword) {
    String lowerKeyword = keyword.toLowerCase();
    return expenses.where((expense) =>
      expense.title.toLowerCase().contains(lowerKeyword) ||
      expense.description.toLowerCase().contains(lowerKeyword) ||
      // --- PERBAIKAN: Gunakan expense.category.name ---
      expense.category.name.toLowerCase().contains(lowerKeyword)
    ).toList();
  }

  static double getAverageDaily(List<Expense> expenses) {
    if (expenses.isEmpty) return 0;
    // --- PERBAIKAN: Gunakan 0.0 untuk tipe data yang konsisten ---
    double total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    
    Set<String> uniqueDays = expenses.map((expense) => 
      '${expense.date.year}-${expense.date.month}-${expense.date.day}'
    ).toSet();
    
    if (uniqueDays.isEmpty) return 0;
    return total / uniqueDays.length;
  }
}

