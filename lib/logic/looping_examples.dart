import '../models/expense_model.dart';

class LoopingExamples {
  // Data sampel dengan ID unik
  static List<Expense> expenses = [
    Expense(id: 'e1', title: 'Kopi Pagi', description: 'Espresso', amount: 25000, date: DateTime(2023, 10, 20), category: 'Makanan'),
    Expense(id: 'e2', title: 'Bensin Motor', description: 'Isi Pertamax', amount: 30000, date: DateTime(2023, 10, 20), category: 'Transportasi'),
    Expense(id: 'e3', title: 'Nasi Goreng', description: 'Makan malam', amount: 20000, date: DateTime(2023, 10, 21), category: 'Makanan'),
    Expense(id: 'e4', title: 'Tiket Bioskop', description: 'Nonton film', amount: 50000, date: DateTime(2023, 10, 22), category: 'Hiburan'),
  ];

  // 1. Menghitung total dengan berbagai cara
  static double calculateTotalTraditional(List<Expense> expenses) {
    double total = 0;
    for (int i = 0; i < expenses.length; i++) {
      total += expenses[i].amount;
    }
    return total;
  }

  static double calculateTotalForIn(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

  static double calculateTotalForEach(List<Expense> expenses) {
    double total = 0;
    expenses.forEach((expense) {
      total += expense.amount;
    });
    return total;
  }

  static double calculateTotalFold(List<Expense> expenses) {
    // Perbaikan: Gunakan 0.0 agar tipe data konsisten (double)
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  static double calculateTotalReduce(List<Expense> expenses) {
    if (expenses.isEmpty) return 0;
    return expenses.map((e) => e.amount).reduce((a, b) => a + b);
  }

  // 2. Mencari item dengan berbagai cara
  static Expense? findExpenseTraditional(List<Expense> expenses, String id) {
    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i].id == id) {
        return expenses[i];
      }
    }
    return null;
  }

  static Expense? findExpenseWhere(List<Expense> expenses, String id) {
    try {
      // orElse: null akan mengembalikan null jika tidak ditemukan, lebih aman dari try-catch
      return expenses.firstWhere((expense) => expense.id == id, orElse: () => null!);
    } catch (e) {
      return null;
    }
  }

  // 3. Filtering dengan berbagai cara
  static List<Expense> filterByCategoryManual(List<Expense> expenses, String category) {
    List<Expense> result = [];
    for (Expense expense in expenses) {
      if (expense.category.toLowerCase() == category.toLowerCase()) {
        result.add(expense);
      }
    }
    return result;
  }

  static List<Expense> filterByCategoryWhere(List<Expense> expenses, String category) {
    return expenses.where((expense) =>
      expense.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }
}
