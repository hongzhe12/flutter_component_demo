import 'package:flutter/material.dart';

class TodoInput extends StatefulWidget {
  const TodoInput({super.key, required this.onSubmit});

  final Future<void> Function(String) onSubmit;

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await widget.onSubmit(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                isDense: true,
                hintText: '请输入你的想做的事情',
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),
          ElevatedButton(onPressed: _submit, child: const Text('提交')),
        ],
      ),
    );
  }
}
