class TodoItem {
  final int id;
  final String title;
  final bool completed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TodoItem({
    required this.id,
    required this.title,
    required this.completed,
    this.createdAt,
    this.updatedAt,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
