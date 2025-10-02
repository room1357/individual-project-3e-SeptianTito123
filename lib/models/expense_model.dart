import 'package:intl/intl.dart';
import 'category.dart'; // Import model Category

class Expense {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final Category category; // <-- UBAH DARI STRING KE CATEGORY

  Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.category, // <-- PERBARUI CONSTRUCTOR
  });

  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(date);
  }

  String get formattedAmount {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }
}

