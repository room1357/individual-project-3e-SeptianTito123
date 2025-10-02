import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/expense_service.dart';
import 'add_edit_expense_screen.dart';

class AdvancedExpenseListScreen extends StatefulWidget {
  const AdvancedExpenseListScreen({super.key});

  @override
  State<AdvancedExpenseListScreen> createState() => _AdvancedExpenseListScreenState();
}

class _AdvancedExpenseListScreenState extends State<AdvancedExpenseListScreen> {
  final _expenseService = ExpenseService();
  late List<Expense> _masterExpenses; // Daftar asli dari service
  List<Expense> _filteredExpenses = []; // Daftar yang ditampilkan setelah difilter

  final TextEditingController searchController = TextEditingController();
  String selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    _loadAndFilterExpenses();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _loadAndFilterExpenses() {
    setState(() {
      _masterExpenses = _expenseService.getExpenses();
      _filterExpenses(); // Langsung terapkan filter saat data dimuat
    });
  }

  void _navigateAndRefresh(Widget screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    if (result == true) {
      _loadAndFilterExpenses();
    }
  }

  void _filterExpenses() {
    setState(() {
      _filteredExpenses = _masterExpenses.where((expense) {
        final search = searchController.text.toLowerCase();
        final matchesSearch = search.isEmpty ||
            expense.title.toLowerCase().contains(search) ||
            expense.description.toLowerCase().contains(search);
        
        final matchesCategory = selectedCategory == 'Semua' ||
            expense.category.name == selectedCategory;
        
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajer Pengeluaran'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Cari pengeluaran...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
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
                      )).toList(),
            ),
          ),
          
          // Statistics summary
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Total', _calculateTotal(_filteredExpenses)),
                _buildStatCard('Jumlah', '${_filteredExpenses.length} item'),
                _buildStatCard('Rata-rata', _calculateAverage(_filteredExpenses)),
              ],
            ),
          ),
          
          // Expense list
          Expanded(
            child: _filteredExpenses.isEmpty
                ? const Center(child: Text('Tidak ada data.'))
                : ListView.builder(
                    itemCount: _filteredExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = _filteredExpenses[index];
                      return Dismissible(
                        key: ValueKey(expense.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _expenseService.deleteExpense(expense.id);
                          _loadAndFilterExpenses(); // Muat ulang & filter ulang
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${expense.title} dihapus')),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getCategoryColor(expense.category.name),
                              child: Icon(expense.category.icon, color: Colors.white),
                            ),
                            title: Text(expense.title),
                            subtitle: Text('${expense.category.name} • ${expense.formattedDate}'),
                            trailing: Text(expense.formattedAmount, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[700])),
                            onTap: () => _navigateAndRefresh(AddEditExpenseScreen(expense: expense)),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndRefresh(const AddEditExpenseScreen()),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
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
    double total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    return 'Rp ${total.toStringAsFixed(0)}';
  }

  String _calculateAverage(List<Expense> expenses) {
    if (expenses.isEmpty) return 'Rp 0';
    double average = expenses.fold(0.0, (sum, expense) => sum + expense.amount) / expenses.length;
    return 'Rp ${average.toStringAsFixed(0)}';
  }

  Color _getCategoryColor(String categoryName) {
    switch (categoryName) {
      case 'Makanan': return Colors.orange;
      case 'Transportasi': return Colors.blue;
      case 'Utilitas': return Colors.green;
      case 'Hiburan': return Colors.red;
      case 'Pendidikan': return Colors.purple;
      default: return Colors.grey;
    }
  }
}

