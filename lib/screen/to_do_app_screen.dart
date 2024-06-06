import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class ToDoScreen extends ConsumerWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final filter = ref.watch(filterProvider);

    final filteredTasks = tasks.where((task) {
      if (filter == 'All') return true;
      if (filter == 'Active') return !task.isCompleted;
      if (filter == 'Favourite') return task.isFavorite;
      if (filter == 'Done') return task.isCompleted;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your Todos in your elegant Todopad',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'My Todopad',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'What do you want to do?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ToggleButtons(
                  isSelected: [
                    filter == 'All',
                    filter == 'Active',
                    filter == 'Favourite',
                    filter == 'Done'
                  ],
                  onPressed: (index) {
                    final newFilter =
                        ['All', 'Active', 'Favourite', 'Done'][index];
                    ref.read(filterProvider.notifier).state = newFilter;
                  },
                  selectedColor: Colors.white,
                  color: Colors.black,
                  fillColor: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  constraints: const BoxConstraints(minWidth: 90),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('All'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Active'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Favourite'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Done'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${tasks.where((task) => task.isCompleted).length} of ${tasks.length} tasks completed',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return TaskTile(
                    task: task,
                    onChanged: (isCompleted) {
                      final taskIndex = tasks.indexOf(task);
                      ref
                          .read(tasksProvider.notifier)
                          .toggleTaskCompletion(taskIndex);
                    },
                    onFavoriteToggle: () {
                      final taskIndex = tasks.indexOf(task);
                      ref
                          .read(tasksProvider.notifier)
                          .toggleTaskFavorite(taskIndex);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
