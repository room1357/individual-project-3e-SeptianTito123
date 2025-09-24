import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../logic/looping_examples.dart';
import '../models/expense_model.dart';

class LoopingExamplesScreen extends StatelessWidget {
  const LoopingExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = LoopingExamples.expenses;
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    // 1. Kalkulasi Total
    final total1 = LoopingExamples.calculateTotalTraditional(expenses);
    final total2 = LoopingExamples.calculateTotalForIn(expenses);
    final total3 = LoopingExamples.calculateTotalForEach(expenses);
    final total4 = LoopingExamples.calculateTotalFold(expenses);
    final total5 = LoopingExamples.calculateTotalReduce(expenses);

    // 2. Pencarian Item
    final found1 = LoopingExamples.findExpenseTraditional(expenses, 'e3'); // Cari Nasi Goreng
    final found2 = LoopingExamples.findExpenseWhere(expenses, 'e4'); // Cari Tiket Bioskop

    // 3. Filtering
    final filtered1 = LoopingExamples.filterByCategoryManual(expenses, 'Makanan');
    final filtered2 = LoopingExamples.filterByCategoryWhere(expenses, 'Makanan');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Looping'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('1. Menghitung Total Pengeluaran'),
          _buildResultCard('For Loop Tradisional', currencyFormatter.format(total1)),
          _buildResultCard('For-in Loop', currencyFormatter.format(total2)),
          _buildResultCard('forEach Method', currencyFormatter.format(total3)),
          _buildResultCard('fold Method', currencyFormatter.format(total4)),
          _buildResultCard('reduce Method', currencyFormatter.format(total5)),

          const SizedBox(height: 24),
          _buildSectionTitle('2. Mencari Item (ID "e3" & "e4")'),
          _buildResultCard('For Loop (Cari e3)', found1?.title ?? 'Tidak ditemukan'),
          _buildResultCard('firstWhere (Cari e4)', found2?.title ?? 'Tidak ditemukan'),
          
          const SizedBox(height: 24),
          _buildSectionTitle('3. Filtering Kategori "Makanan"'),
          _buildResultCard('Manual Loop', '${filtered1.length} item ditemukan'),
          _buildResultCard('where Method', '${filtered2.length} item ditemukan'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget _buildResultCard(String title, String result) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Text(result, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
