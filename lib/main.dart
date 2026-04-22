// lib/main.dart
import 'package:flutter/material.dart';

// 1. 应用入口：固定写法
void main() => runApp(const MyApp());

// 2. 根组件：应用的顶级容器
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Material风格根组件（必须有）
    return MaterialApp(
      title: '组件学习',
      theme: ThemeData(primarySwatch: Colors.blue),
      // 主页：页面容器（必须有）
      home: const HomePage(),
    );
  }
}

// 3. 主页组件：我们的页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold：页面基础结构
    return Scaffold(
      appBar: AppBar(title: const Text('自定义组件演示')),
      // 👇 在这里放你的自定义组件！
      body: MyCustomCard(),
    );
  }
}

// ======================================
// ✨ 你的自定义组件 写在这里！
// ======================================
class MyCustomCard extends StatelessWidget {
  // 1. 创建控制器
  final TextEditingController _textController = TextEditingController();

  MyCustomCard({super.key});

  void _onSavePressed() {
    String inputText = _textController.text;
    debugPrint('输入的内容是：$inputText');
  }

  @override
  Widget build(BuildContext context) {
    // 这就是你要学习编写的组件
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                isDense: true,
                hintText: '请输入你的想做的事情', // 提示文字
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // 背景颜色
              foregroundColor: Colors.white, // 字体颜色
            ),
            onPressed: _onSavePressed,
            child: const Text('提交'),
          ),
        ],
      ),
    );
  }
}
