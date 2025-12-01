class Category {
  final int id;
  final String name;
  final DateTime lastEdit;
  final String? description;

  const Category({
    required this.id,
    required this.name,
    required this.lastEdit,
    this.description,
  });
}
