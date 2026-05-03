import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import '../services/todo_api.dart';
import '../widgets/todo_input.dart';
import '../widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoApi _api = TodoApi();
  List<TodoItem> _todos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _api.dispose();
    super.dispose();
  }

  Future<void> _loadTodos() async {
    setState(() => _loading = true);
    try {
      final data = await _api.getTodos();
      if (!mounted) return;
      setState(() => _todos = data);
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _addTodo(String text) async {
    try {
      final created = await _api.createTodo(text);
      if (!mounted) return;
      setState(() => _todos = [..._todos, created]);
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    }
  }

  Future<void> _removeTodo(TodoItem item) async {
    try {
      await _api.deleteTodo(item.id);
      if (!mounted) return;
      setState(() => _todos = _todos.where((t) => t.id != item.id).toList());
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    }
  }

  Future<void> _toggleTodo(TodoItem item, bool value) async {
    try {
      final updated = await _api.updateTodo(item.id, completed: value);
      if (!mounted) return;
      setState(() {
        _todos = _todos.map((t) => t.id == updated.id ? updated : t).toList();
      });
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    }
  }

  Future<void> _showEditDialog(TodoItem item) async {
    final controller = TextEditingController(text: item.title);
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('编辑事项'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              isDense: true,
              hintText: '请输入新的内容',
            ),
            onSubmitted: (_) => Navigator.of(context).pop(controller.text),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('保存'),
            ),
          ],
        );
      },
    );

    if (result == null) return;
    final text = result.trim();
    if (text.isEmpty) return;

    try {
      final updated = await _api.updateTodo(item.id, title: text);
      if (!mounted) return;
      setState(() {
        _todos = _todos.map((t) => t.id == updated.id ? updated : t).toList();
      });
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('待办事项列表'),
        actions: [
          IconButton(onPressed: _loadTodos, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TodoInput(onSubmit: _addTodo),
                Expanded(
                  child: TodoList(
                    todos: _todos,
                    onDelete: _removeTodo,
                    onEdit: _showEditDialog,
                    onToggle: _toggleTodo,
                  ),
                ),
              ],
            ),
    );
  }
}
