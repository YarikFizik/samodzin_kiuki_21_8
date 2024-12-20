import 'package:flutter/material.dart';
import '../models/learner.dart';
import '../models/division.dart';

class LearnerForm extends StatefulWidget {
  final Learner? learner;
  final Function(Learner) onSave;

  const LearnerForm({super.key, this.learner, required this.onSave});

  @override
  State<LearnerForm> createState() => _LearnerFormState();
}

class _LearnerFormState extends State<LearnerForm> {
  final _givenNameController = TextEditingController();
  final _familyNameController = TextEditingController();
  Division? _selectedDivision;
  Gender? _selectedGender;
  int _score = 50;

  @override
  void initState() {
    super.initState();
    if (widget.learner != null) {
      _givenNameController.text = widget.learner!.givenName;
      _familyNameController.text = widget.learner!.familyName;
      _selectedDivision = widget.learner!.division;
      _selectedGender = widget.learner!.gender;
      _score = widget.learner!.score;
    }
  }

  void _saveLearner() {
    if (_selectedDivision == null || _selectedGender == null) return;

    final updatedLearner = Learner(
      givenName: _givenNameController.text.trim(),
      familyName: _familyNameController.text.trim(),
      division: _selectedDivision!,
      score: _score,
      gender: _selectedGender!,
    );

    widget.onSave(updatedLearner);
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
              onChanged: (value) => setState(() => _selectedDivision = value),
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
              onChanged: (value) => setState(() => _selectedGender = value),
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
