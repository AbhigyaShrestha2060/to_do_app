import 'package:flutter/material.dart';

import '../model/task.dart';


class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onFavoriteToggle;

  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: onChanged,
          activeColor: Colors.purple,
        ),
        title: Text(
          task.name,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            task.isFavorite ? Icons.star : Icons.star_border,
            color: task.isFavorite ? Colors.yellow : Colors.grey,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
