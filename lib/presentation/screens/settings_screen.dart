import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/widgets/category_tile.dart';
import 'package:organizer/presentation/widgets/multi_function_floating_button.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: provider.categories.isEmpty
          ? const Center(child: Text('No categories yet.'))
          : ListView.builder(
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                final cat = provider.categories[index];
                return CategoryTile(category: cat);
              },
            ),
      floatingActionButton: MultiFunctionFloatingButton(),
    );
  }
}
