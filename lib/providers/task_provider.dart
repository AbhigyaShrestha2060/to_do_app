import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/model/task.dart';

final tasksProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier([
    Task(name: 'electricity', isFavorite: true),
    Task(name: 'Call', isCompleted: true),
    Task(name: 'Visit', isCompleted: true),
    Task(name: 'Buy sweets', isFavorite: true),
  ]);
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier(super.initialTasks);

  void toggleTaskCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(isCompleted: !state[i].isCompleted)
        else
          state[i]
    ];
  }

  void toggleTaskFavorite(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(isFavorite: !state[i].isFavorite)
        else
          state[i]
    ];
  }
}

final filterProvider = StateProvider<String>((ref) => 'All');
