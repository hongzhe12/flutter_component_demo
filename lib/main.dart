import 'dart:io';

import 'package:flutter/material.dart';

import 'network/http_override.dart';
import 'pages/home_page.dart';

void main() {
  // 必须在 runApp 之前设置
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

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
