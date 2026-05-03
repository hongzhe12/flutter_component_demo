import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/todo_item.dart';

class TodoApi {
  TodoApi({http.Client? client}) : _client = client ?? http.Client();

  static const String baseUrl = 'https://47.94.239.145/o/app';
  final http.Client _client;

  Uri _todosUri([int? id]) {
    if (id == null) return Uri.parse('$baseUrl/api/todos/');
    return Uri.parse('$baseUrl/api/todos/$id/');
  }

  Future<http.Response> _request(Future<http.Response> Function() call) async {
    try {
      return await call();
    } on http.ClientException catch (e) {
      print('HTTP ClientException: ${e.message}');
      if (e.message.contains('Failed to fetch')) {
        throw Exception(
          '网络请求失败：请检查接口地址、服务可达性，或确认浏览器未拦截混合内容请求。',
        );
      }
      rethrow;
    }
  }

  Future<List<TodoItem>> getTodos() async {
    final response = await _request(() => _client.get(_todosUri()));
    final data = _decode(response) as List<dynamic>;
    return data
        .map((item) => TodoItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<TodoItem> createTodo(String title, {bool completed = false}) async {
    final response = await _request(
      () => _client.post(
        _todosUri(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'completed': completed}),
      ),
    );
    return TodoItem.fromJson(_decode(response) as Map<String, dynamic>);
  }

  Future<TodoItem> updateTodo(
    int id, {
    String? title,
    bool? completed,
  }) async {
    final payload = <String, dynamic>{
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
    };

    final response = await _request(
      () => _client.patch(
        _todosUri(id),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      ),
    );
    return TodoItem.fromJson(_decode(response) as Map<String, dynamic>);
  }

  Future<void> deleteTodo(int id) async {
    final response = await _request(() => _client.delete(_todosUri(id)));
    if (response.statusCode != 204) {
      throw Exception('删除失败: ${response.statusCode} ${response.body}');
    }
  }

  dynamic _decode(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('请求失败: ${response.statusCode} ${response.body}');
    }
    if (response.body.isEmpty) return null;
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  void dispose() {
    _client.close();
  }
}
