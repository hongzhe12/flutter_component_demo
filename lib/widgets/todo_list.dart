import 'package:flutter/material.dart';

import '../models/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
    required this.onDelete,
    required this.onEdit,
    required this.onToggle,
  });

  final List<TodoItem> todos;
  final Future<void> Function(TodoItem) onDelete;
  final Future<void> Function(TodoItem) onEdit;
  final Future<void> Function(TodoItem, bool) onToggle;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('暂无待办，先添加一个吧'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final item = todos[index];
        return ListTile(
          leading: Checkbox(
            value: item.completed,
            onChanged: (value) {
              if (value == null) return;
              onToggle(item, value);
            },
          ),
          title: Text(
            item.title,
            style: TextStyle(
              decoration: item.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(item),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(item),
              ),
            ],
          ),
        );
      },
    );
  }
}
