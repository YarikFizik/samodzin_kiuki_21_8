import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/division.dart';
import '../providers/learners_provider.dart';

class DepartmentsOverview extends ConsumerWidget {
  const DepartmentsOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learners = ref.watch(learnersProvider);

    final departmentCounts = {
      for (var division in Division.values)
        division: learners.where((l) => l.division == division).length,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.book,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: Division.values.length,
        itemBuilder: (context, index) {
          final department = Division.values[index];
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal.shade100,
                  Colors.teal.shade300,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    departmentIcons[department],
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  departmentNames[department]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${departmentCounts[department]} Students',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
