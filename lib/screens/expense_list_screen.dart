import 'package:flutter/material.dart';
import '../../logic/expense_manager.dart';
import '../../models/expense_model.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dan hasil kalkulasi dari ExpenseManager
    final allExpenses = ExpenseManager.expenses;
    final totalByCategory = ExpenseManager.getTotalByCategory(allExpenses);
    final highestExpense = ExpenseManager.getHighestExpense(allExpenses);
    final novemberExpenses = ExpenseManager.getExpensesByMonth(allExpenses, 11, 2023);
    final searchResults = ExpenseManager.searchExpenses(allExpenses, 'Motor');
    final averageDaily = ExpenseManager.getAverageDaily(allExpenses);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis Pengeluaran'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('[1] Total per Kategori'),
          // Tampilkan total per kategori
          ...totalByCategory.entries.map((entry) {
            return Card(
              child: ListTile(
                title: Text(entry.key),
                trailing: Text('Rp ${entry.value.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          }).toList(),

          const SizedBox(height: 20),
          _buildSectionTitle('[2] Pengeluaran Tertinggi'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.arrow_upward, color: Colors.red),
              title: Text(highestExpense?.title ?? 'Tidak ada data'),
              trailing: Text('Rp ${highestExpense?.amount.toStringAsFixed(0) ?? '0'}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),

          const SizedBox(height: 20),
          _buildSectionTitle('[3] Pengeluaran Bulan November 2023'),
          // Tampilkan pengeluaran November
          ...novemberExpenses.map((expense) => Card(
            child: ListTile(title: Text(expense.title), trailing: Text(expense.category)),
          )).toList(),
          
          const SizedBox(height: 20),
          _buildSectionTitle('[4] Hasil Pencarian "Motor"'),
          ...searchResults.map((expense) => Card(
            child: ListTile(title: Text(expense.title), subtitle: Text(expense.description)),
          )).toList(),

          const SizedBox(height: 20),
          _buildSectionTitle('[5] Rata-rata Pengeluaran Harian'),
           Card(
            child: ListTile(
              leading: const Icon(Icons.calculate, color: Colors.blue),
              title: const Text('Rata-rata per hari'),
              trailing: Text('Rp ${averageDaily.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk membuat judul seksi
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
  }
}
