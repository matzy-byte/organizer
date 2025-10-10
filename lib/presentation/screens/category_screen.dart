import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:organizer/presentation/widgets/topic_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cat = ModalRoute.of(context)!.settings.arguments as Category;
    
    return Scaffold(
      drawer: Drawer(
        child: DrawerContent(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: cat.name),
              TopicCard(name: "name", description: "yeee",)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Dialog(),
        ),
      ),
    );
  }
}
