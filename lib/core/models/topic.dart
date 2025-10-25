class Topic {
  final int id;
  final int categoryId;
  final String name;
  final String? description;

  const Topic({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
  });
}
