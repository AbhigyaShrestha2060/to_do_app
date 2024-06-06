class Task {
  final String name;
  final bool isCompleted;
  final bool isFavorite;

  Task({
    required this.name,
    this.isCompleted = false,
    this.isFavorite = false,
  });

  Task copyWith({
    String? name,
    bool? isCompleted,
    bool? isFavorite,
  }) {
    return Task(
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
