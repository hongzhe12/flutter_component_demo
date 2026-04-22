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
      body: const MyCustomCard(),
    );
  }
}

// ======================================
// ✨ 你的自定义组件 写在这里！
// ======================================
class MyCustomCard extends StatelessWidget {
  const MyCustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 这就是你要学习编写的组件
    return const Center(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            '我是自定义组件！',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
