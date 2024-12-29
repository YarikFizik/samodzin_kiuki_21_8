import 'package:flutter/material.dart';
import '../models/learner.dart';
import '../models/division.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/learners_provider.dart';

class LearnerForm extends ConsumerStatefulWidget {
  const LearnerForm({
    super.key,
    this.learnerIndex
  });

  final int? learnerIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LearnerFormState();
}

class _LearnerFormState extends ConsumerState<LearnerForm> {
  final _givenNameController = TextEditingController();
  final _familyNameController = TextEditingController();
  Division _selectedDivision = Division.finance;
  Gender _selectedGender = Gender.male;
  int _score = 50;

  @override
  void initState() {
    super.initState();
    if (widget.learnerIndex != null) {
      final student = ref.read(learnersProvider).learners[widget.learnerIndex!];
      _givenNameController.text = student.givenName;
      _familyNameController.text = student.familyName;
      _selectedDivision = student.division;
      _selectedGender = student.gender;
      _score = student.score;
    }
  }

  void _saveLearner() async {
    if (widget.learnerIndex == null)  {
      await ref.read(learnersProvider.notifier).addLearner(
            _givenNameController.text.trim(),
            _familyNameController.text.trim(),
            _selectedDivision,
            _selectedGender,
            _score,
          );
    } else {
      await ref.read(learnersProvider.notifier).updateLearner(
            widget.learnerIndex!,
            _givenNameController.text.trim(),
            _familyNameController.text.trim(),
            _selectedDivision,
            _selectedGender,
            _score,
          );
    }

    if (!context.mounted) return;
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add or Edit Learner',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _givenNameController,
              decoration: InputDecoration(
                labelText: 'Given Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.teal.shade50,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _familyNameController,
              decoration: InputDecoration(
                labelText: 'Family Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.teal.shade50,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Division>(
              value: _selectedDivision,
              decoration: InputDecoration(
                labelText: 'Division',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: Division.values.map((dept) {
                return DropdownMenuItem(
                  value: dept,
                  child: Row(
                    children: [
                      Icon(
                        departmentIcons[dept],
                        color: Colors.teal,
                      ),
                      const SizedBox(width: 8),
                      Text(departmentNames[dept]!),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedDivision = value!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Gender>(
              value: _selectedGender,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: Gender.values.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(
                    gender.toString().split('.').last,
                    style: const TextStyle(color: Colors.teal),
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedGender = value!),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Score:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _score.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  activeColor: Colors.teal,
                  inactiveColor: Colors.teal.shade100,
                  label: '$_score',
                  onChanged: (value) => setState(() => _score = value.toInt()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _saveLearner,
              child: const Text(
                'Save Learner',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
