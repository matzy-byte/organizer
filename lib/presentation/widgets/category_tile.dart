import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/alert_delete.dart';
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
          final confirm = await AlertDelete.show(context, type: 'Category', value: category.name);
          if (confirm == true) await provider.removeCategory(category);
        },
      ),
    );
  }
}