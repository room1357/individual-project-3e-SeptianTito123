import '../models/expense_model.dart';

class ExpenseManager {
  // Data sampel untuk pengujian
  static List<Expense> expenses = [
    Expense(id: 'em1', title: 'Kopi Pagi', description: 'Espresso di cafe', amount: 25000, date: DateTime(2023, 10, 20), category: 'Makanan'),
    Expense(id: 'em2', title: 'Bensin Motor', description: 'Isi Pertamax', amount: 30000, date: DateTime(2023, 10, 20), category: 'Transportasi'),
    Expense(id: 'em3', title: 'Nasi Goreng', description: 'Makan malam', amount: 20000, date: DateTime(2023, 10, 21), category: 'Makanan'),
    Expense(id: 'em4', title: 'Tiket Bioskop', description: 'Nonton film baru', amount: 50000, date: DateTime(2023, 10, 22), category: 'Hiburan'),
    Expense(id: 'em5', title: 'Belanja Bulanan', description: 'Sabun, sampo, dll', amount: 150000, date: DateTime(2023, 11, 1), category: 'Kebutuhan'),
    Expense(id: 'em6', title: 'Paket Data', description: 'Kuota internet', amount: 75000, date: DateTime(2023, 11, 5), category: 'Kebutuhan'),
    Expense(id: 'em7', title: 'Service Motor', description: 'Ganti oli rutin', amount: 80000, date: DateTime(2023, 11, 15), category: 'Transportasi'),
    Expense(id: 'em8', title: 'Kopi Siang', description: 'Americano', amount: 22000, date: DateTime(2023, 11, 15), category: 'Makanan'),
  ];

  // 1. Mendapatkan total pengeluaran per kategori
  static Map<String, double> getTotalByCategory(List<Expense> expenses) {
    Map<String, double> result = {};
    for (var expense in expenses) {
      // Jika kategori sudah ada di map, tambahkan amount. Jika belum, buat baru.
      // `?? 0` berarti jika `result[expense.category]` null, maka gunakan nilai 0.
      result[expense.category] = (result[expense.category] ?? 0) + expense.amount;
    }
    return result;
  }

  // 2. Mendapatkan pengeluaran tertinggi
  static Expense? getHighestExpense(List<Expense> expenses) {
    if (expenses.isEmpty) return null;
    // `reduce` membandingkan dua elemen berturut-turut dan menyimpan
    // elemen yang memenuhi kondisi (dalam kasus ini, yang amount-nya lebih besar).
    return expenses.reduce((a, b) => a.amount > b.amount ? a : b);
  }

  // 3. Mendapatkan pengeluaran bulan tertentu
  static List<Expense> getExpensesByMonth(List<Expense> expenses, int month, int year) {
    // `where` menyaring list berdasarkan kondisi yang diberikan.
    return expenses.where((expense) =>
      expense.date.month == month && expense.date.year == year
    ).toList(); // .toList() mengubah hasil (Iterable) kembali menjadi List.
  }

  // 4. Mencari pengeluaran berdasarkan kata kunci
  static List<Expense> searchExpenses(List<Expense> expenses, String keyword) {
    String lowerKeyword = keyword.toLowerCase();
    return expenses.where((expense) =>
      expense.title.toLowerCase().contains(lowerKeyword) ||
      expense.description.toLowerCase().contains(lowerKeyword) ||
      expense.category.toLowerCase().contains(lowerKeyword)
    ).toList();
  }

  // 5. Mendapatkan rata-rata pengeluaran harian
  static double getAverageDaily(List<Expense> expenses) {
    if (expenses.isEmpty) return 0;
    
    // `fold` menjumlahkan semua amount dalam list menjadi satu nilai double.
    double total = expenses.fold(0, (sum, expense) => sum + expense.amount);
    
    // Untuk menghitung hari unik:
    // 1. `map` mengubah setiap expense menjadi string 'tahun-bulan-hari'.
    // 2. `toSet()` mengubahnya menjadi Set, yang secara otomatis menghapus duplikat.
    Set<String> uniqueDays = expenses.map((expense) => 
      '${expense.date.year}-${expense.date.month}-${expense.date.day}'
    ).toSet();
    
    if (uniqueDays.isEmpty) return 0;
    return total / uniqueDays.length;
  }
}
