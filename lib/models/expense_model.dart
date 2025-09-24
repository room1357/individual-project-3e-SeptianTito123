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

  // Override toString() untuk mempermudah saat mencetak (print) object
  @override
  String toString() {
    return 'Expense(title: $title, amount: $amount, date: $date, category: $category)';
  }
}