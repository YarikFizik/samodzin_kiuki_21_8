import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/learners_provider.dart';
import 'learner_form.dart';
import 'learner_card.dart';

class LearnersOverview extends ConsumerWidget {
  const LearnersOverview({super.key});

  void _openLearnerForm(BuildContext context, WidgetRef ref,
      {int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return LearnerForm(learnerIndex: index,);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(learnersProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.exceptionMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.exceptionMsg!,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.school,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: state.learners.isEmpty
          ? const Center(
              child: Text(
                'No students found.\nTap the button below to add!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.learners.length,
              itemBuilder: (context, index) {
                final learner = state.learners[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: LearnerCard(
                    learner: learner,
                    onDelete: () {
                      ref.read(learnersProvider.notifier).removeLearner(index);
                      final gpt = ProviderScope.containerOf(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Learner removed'),
                          action: SnackBarAction(
                            label: 'Undo',
                            textColor: Colors.orange,
                            onPressed: () => gpt
                                .read(learnersProvider.notifier)
                                .restoreLearner(),
                          ),
                        ),
                      ).closed.then((value) {
                        if (value != SnackBarClosedReason.action) {
                          gpt.read(learnersProvider.notifier).del();
                        }
                      });
                    },
                    onUpdate: () => _openLearnerForm(context, ref, index: index),
                  ),
                );
              },
            ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 42, bottom: 24),
          child: ElevatedButton.icon(
            onPressed: () => _openLearnerForm(context, ref),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              elevation: 4,
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Add Learner',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
