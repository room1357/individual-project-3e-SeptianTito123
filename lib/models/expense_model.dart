import 'package:intl/intl.dart'; // Import package intl

class Expense {
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  // --- GETTER BARU UNTUK FORMAT TANGGAL ---
  // Mengubah DateTime menjadi format "dd MMM yyyy" (contoh: 24 Sep 2025)
  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // --- GETTER BARU UNTUK FORMAT MATA UANG ---
  // Mengubah double menjadi format mata uang Rupiah
  String get formattedAmount {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID', // Locale Indonesia
      symbol: 'Rp ',    // Simbol Rupiah
      decimalDigits: 0, // Tidak menampilkan desimal
    );
    return formatCurrency.format(amount);
  }

  @override
  String toString() {
    return 'Expense(title: $title, amount: $amount, date: $date, category: $category)';
  }
}