import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'homescreens/profile_screen.dart';
import 'homescreens/settings_screen.dart';
import 'expense_list_screen.dart';
import 'advanced_expense_list_screen.dart';
import 'looping_examples_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome User!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur Pesan belum tersedia')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur Bantuan belum tersedia')),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.analytics, color: Colors.indigo),
              title: const Text('Analisis Pengeluaran'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseListScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_list, color: Colors.deepPurple),
              title: const Text('Pengeluaran (Advanced)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdvancedExpenseListScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.loop, color: Colors.teal),
              title: const Text('Latihan Looping'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoopingExamplesScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      // --- PERBAIKAN UTAMA ADA DI SINI ---
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                // Properti ini penting agar GridView tidak bentrok dengan SingleChildScrollView
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // --- KEMBALIKAN JADI 2 KOLOM AGAR RAPI ---
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard('Profile', Icons.person, Colors.green, context, () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  }),
                  _buildDashboardCard('Messages', Icons.message, Colors.orange, context, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur Pesan belum tersedia')),
                    );
                  }),
                  _buildDashboardCard('Settings', Icons.settings, Colors.purple, context, () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  }),
                  _buildDashboardCard('Help', Icons.help, Colors.red, context, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur Bantuan belum tersedia')),
                    );
                  }),
                  _buildDashboardCard('Analisis', Icons.analytics, Colors.indigo, context, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseListScreen()));
                  }),
                  _buildDashboardCard('Advanced', Icons.filter_list, Colors.deepPurple, context, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdvancedExpenseListScreen()));
                  }),
                  // Kartu Looping mungkin akan membuat baris baru, jadi kita letakkan di sini
                  _buildDashboardCard('Looping', Icons.loop, Colors.teal, context, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoopingExamplesScreen()));
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, Color color, BuildContext context, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

