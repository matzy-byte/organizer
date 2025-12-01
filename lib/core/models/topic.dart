class Topic {
  final int id;
  final int categoryId;
  final String name;
  final DateTime lastEdit;
  final String? description;

  const Topic({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.lastEdit,
    this.description,
  });
}
