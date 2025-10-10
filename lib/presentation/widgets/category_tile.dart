import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  
  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CategoryProvider>();

    return ListTile(
      title: Text(category.name),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Category?'),
              content: Text('Are you sure you want to delete "${category.name}"?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
              ],
            ),
          );
          if (confirm == true) await provider.removeCategory(category.id);
        },
      ),
    );
  }
}