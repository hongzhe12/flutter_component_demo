// lib/main.dart
import 'package:flutter/material.dart';

// 1. 应用入口：固定写法
void main() => runApp(const MyApp());

// 2. 根组件：应用的顶级容器
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '待办事项',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// 3. 主页组件：我们的页面
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _todos = [];

  void _addTodo(String text) {
    setState(() {
      _todos.add(text);
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _editTodo(int index, String newText) {
    setState(() {
      _todos[index] = newText;
    });
  }

  Future<void> _showEditDialog(int index) async {
    final controller = TextEditingController(text: _todos[index]);
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
    _editTodo(index, text);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold：页面基础结构
    return Scaffold(
      appBar: AppBar(title: const Text('待办事项列表')),
      body: Column(
        children: [
          TodoInput(onSubmit: _addTodo),
          Expanded(
            child: TodoList(
              todos: _todos,
              onDelete: _removeTodo,
              onEdit: _showEditDialog,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================
// ✨ 你的自定义组件 写在这里！
// ======================================
class TodoInput extends StatelessWidget {
  const TodoInput({super.key, required this.onSubmit});

  final ValueChanged<String> onSubmit;

  void _submit(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    onSubmit(text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                hintText: '请输入你的想做的事情', // 提示文字
              ),
              onSubmitted: (_) => _submit(controller),
            ),
          ),
          ElevatedButton(
            onPressed: () => _submit(controller),
            child: const Text('提交'),
          ),
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
    required this.onDelete,
    required this.onEdit,
  });

  final List<String> todos;
  final void Function(int) onDelete;
  final void Function(int) onEdit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(todos[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(index),
              ),
            ],
          ),
        );
      },
    );
  }
}


// 帮我看看能简化吗，我要最流行，官方推荐的写法：
// 1. 合适新手的代码设计
// 2. 代码简洁