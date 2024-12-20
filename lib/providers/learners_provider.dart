import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/learner.dart';

class LearnersManager extends StateNotifier<List<Learner>> {
  LearnersManager() : super([]);

  Learner? _lastRemovedLearner;
  int? _lastRemovedIndex;

  void addLearner(Learner learner) {
    state = [...state, learner];
  }

  void updateLearner(int index, Learner updatedLearner) {
    final updatedList = [...state];
    updatedList[index] = updatedLearner;
    state = updatedList;
  }

  void removeLearner(int index) {
    _lastRemovedLearner = state[index];
    _lastRemovedIndex = index;
    state = [
      ...state.sublist(0, index),
      ...state.sublist(index + 1),
    ];
  }

  void restoreLearner() {
    if (_lastRemovedLearner != null && _lastRemovedIndex != null) {
      state = [
        ...state.sublist(0, _lastRemovedIndex!),
        _lastRemovedLearner!,
        ...state.sublist(_lastRemovedIndex!),
      ];
      _lastRemovedLearner = null;
      _lastRemovedIndex = null;
    }
  }
}

final learnersProvider = StateNotifierProvider<LearnersManager, List<Learner>>(
  (ref) => LearnersManager(),
);
