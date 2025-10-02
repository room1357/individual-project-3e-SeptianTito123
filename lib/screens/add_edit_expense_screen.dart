import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/category.dart';
import '../models/expense_model.dart';
import '../services/expense_service.dart';

class AddEditExpenseScreen extends StatefulWidget {
  final Expense? expense; // Null jika 'Add', ada isinya jika 'Edit'

  const AddEditExpenseScreen({super.key, this.expense});

  @override
  State<AddEditExpenseScreen> createState() => _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _expenseService = ExpenseService();
  
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  Category? _selectedCategory;

  late List<Category> _categories;
  bool get _isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();
    _categories = _expenseService.getCategories();
    
    _titleController = TextEditingController(text: widget.expense?.title ?? '');
    _descriptionController = TextEditingController(text: widget.expense?.description ?? '');
    _amountController = TextEditingController(text: widget.expense?.amount.toString() ?? '');
    _selectedDate = widget.expense?.date ?? DateTime.now();
    _selectedCategory = widget.expense?.category ?? _categories.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final amount = double.tryParse(_amountController.text) ?? 0;

      if (_isEditing) {
        _expenseService.updateExpense(
          widget.expense!.id,
          title,
          description,
          amount,
          _selectedDate,
          _selectedCategory!,
        );
      } else {
        _expenseService.addExpense(
          title,
          description,
          amount,
          _selectedDate,
          _selectedCategory!,
        );
      }
      Navigator.of(context).pop(true); // Kirim 'true' untuk menandakan ada perubahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Pengeluaran' : 'Tambah Pengeluaran'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) => value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Jumlah (Rp)', prefixText: 'Rp '),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Jumlah tidak boleh kosong';
                  if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(category.icon, size: 20),
                        const SizedBox(width: 8),
                        Text(category.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Tanggal: ${DateFormat('dd MMM yyyy').format(_selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Pilih Tanggal'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(_isEditing ? 'Simpan Perubahan' : 'Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
