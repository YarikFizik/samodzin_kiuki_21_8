import 'package:flutter/material.dart';
import '../models/learner.dart';
import '../models/division.dart';

class LearnerCard extends StatelessWidget {
  final Learner learner;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const LearnerCard({
    super.key,
    required this.learner,
    required this.onUpdate,
    required this.onDelete,
  });

  Color _getCardColor(Gender gender) {
    return gender == Gender.male ? Colors.lightBlue.shade200 : Colors.pink.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: _getCardColor(learner.gender),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  departmentIcons[learner.division],
                  size: 30,
                  color: learner.gender == Gender.male ? Colors.blue : Colors.pink,
                ),
                const SizedBox(height: 8),
                Text(
                  learner.score.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${learner.givenName} ${learner.familyName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.school, size: 16, color: Colors.black54),
                      const SizedBox(width: 6),
                      Text(
                        departmentNames[learner.division]!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: onUpdate,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
