import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense_model.dart';

class AdvancedExpenseListScreen extends StatefulWidget {
  const AdvancedExpenseListScreen({super.key});

  @override
  State<AdvancedExpenseListScreen> createState() => _AdvancedExpenseListScreenState();
}

class _AdvancedExpenseListScreenState extends State<AdvancedExpenseListScreen> {
  // Data sampel yang lebih beragam untuk pengujian
  final List<Expense> expenses = [
      Expense(id: 'adv1', title: 'Nasi Padang', description: 'Makan siang kantor', amount: 25000, date: DateTime(2023, 9, 20), category: 'Makanan'),
      Expense(id: 'adv2', title: 'Tiket Kereta Api', description: 'Perjalanan ke Bandung', amount: 150000, date: DateTime(2023, 9, 21), category: 'Transportasi'),
      Expense(id: 'adv3', title: 'Bayar Listrik', description: 'Tagihan bulanan', amount: 250000, date: DateTime(2023, 9, 22), category: 'Utilitas'),
      Expense(id: 'adv4', title: 'Nonton Bioskop', description: 'Film Aksi Terbaru', amount: 50000, date: DateTime(2023, 9, 23), category: 'Hiburan'),
      Expense(id: 'adv5', title: 'Beli Buku Flutter', description: 'Buku di Gramedia', amount: 120000, date: DateTime(2023, 9, 24), category: 'Pendidikan'),
      Expense(id: 'adv6', title: 'Kopi Susu', description: 'Ngopi sore', amount: 22000, date: DateTime(2023, 9, 24), category: 'Makanan'),
      Expense(id: 'adv7', title: 'Gojek ke Kantor', description: 'Pergi kerja', amount: 15000, date: DateTime(2023, 9, 25), category: 'Transportasi'),
    ];  
    
  List<Expense> filteredExpenses = [];
  String selectedCategory = 'Semua';
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Saat halaman pertama kali dibuka, tampilkan semua data
    filteredExpenses = expenses;
  }
  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengeluaran Advanced'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Cari pengeluaran...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (value) => _filterExpenses(),
            ),
          ),
          
          // Category filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['Semua', 'Makanan', 'Transportasi', 'Utilitas', 'Hiburan', 'Pendidikan']
                  .map((category) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                              _filterExpenses();
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          
          // Statistics summary
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Total', _calculateTotal(filteredExpenses)),
                _buildStatCard('Jumlah', '${filteredExpenses.length} item'),
                _buildStatCard('Rata-rata', _calculateAverage(filteredExpenses)),
              ],
            ),
          ),
          
          // Expense list
          Expanded(
            child: filteredExpenses.isEmpty
                ? const Center(child: Text('Tidak ada pengeluaran ditemukan'))
                : ListView.builder(
                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = filteredExpenses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getCategoryColor(expense.category),
                            child: Icon(_getCategoryIcon(expense.category), color: Colors.white),
                          ),
                          title: Text(expense.title),
                          subtitle: Text('${expense.category} • ${expense.formattedDate}'),
                          trailing: Text(
                            expense.formattedAmount,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[700],
                            ),
                          ),
                          onTap: () => _showExpenseDetails(context, expense),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _filterExpenses() {
    setState(() {
      filteredExpenses = expenses.where((expense) {
        bool matchesSearch = searchController.text.isEmpty ||
            expense.title.toLowerCase().contains(searchController.text.toLowerCase()) ||
            expense.description.toLowerCase().contains(searchController.text.toLowerCase());
        
        bool matchesCategory = selectedCategory == 'Semua' ||
            expense.category == selectedCategory;
        
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  String _calculateTotal(List<Expense> expenses) {
    // PERBAIKAN: Menggunakan 0.0 sebagai nilai awal untuk fold
    double total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(total);
  }

  String _calculateAverage(List<Expense> expenses) {
    if (expenses.isEmpty) return 'Rp 0';
    // PERBAIKAN: Menggunakan 0.0 sebagai nilai awal untuk fold
    double average = expenses.fold(0.0, (sum, expense) => sum + expense.amount) / expenses.length;
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(average);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Makanan': return Colors.orange;
      case 'Transportasi': return Colors.blue;
      case 'Utilitas': return Colors.green;
      case 'Hiburan': return Colors.red;
      case 'Pendidikan': return Colors.purple;
      default: return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Makanan': return Icons.fastfood;
      case 'Transportasi': return Icons.directions_car;
      case 'Utilitas': return Icons.receipt_long;
      case 'Hiburan': return Icons.movie;
      case 'Pendidikan': return Icons.school;
      default: return Icons.money;
    }
  }

  void _showExpenseDetails(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(expense.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Jumlah: ${expense.formattedAmount}'),
                const SizedBox(height: 8),
                Text('Tanggal: ${expense.formattedDate}'),
                const SizedBox(height: 8),
                Text('Kategori: ${expense.category}'),
                const SizedBox(height: 16),
                Text('Deskripsi:\n${expense.description}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

