import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;

  Category({required this.id, required this.name, required this.icon});

  // --- PERBAIKAN 1: Override operator == ---
  // Memberitahu Dart cara membandingkan dua objek Category.
  // Dua objek dianggap sama jika ID-nya sama.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  // --- PERBAIKAN 2: Override hashCode ---
  // Penting untuk di-override bersama dengan operator ==
  // agar objek bisa berfungsi dengan baik di dalam struktur data seperti Map atau Set.
  @override
  int get hashCode => id.hashCode;
}

