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
      title: '组件学习',
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

  @override
  Widget build(BuildContext context) {
    // Scaffold：页面基础结构
    return Scaffold(
      appBar: AppBar(title: const Text('自定义组件演示')),
      body: Column(
        children: [
          TodoInput(onSubmit: _addTodo),
          Expanded(
            child: TodoList(
              todos: _todos,
              onDelete: _removeTodo,
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
  });

  final List<String> todos;
  final void Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(todos[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(index),
          ),
        );
      },
    );
  }
}


// 帮我看看能简化吗，我要最流行，官方推荐的写法：
// 1. 合适新手的代码设计
// 2. 代码简洁