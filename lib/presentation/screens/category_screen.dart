import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:organizer/presentation/widgets/multi_function_floating_button.dart';
import 'package:organizer/presentation/widgets/topic_card.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    final topicProvider = context.watch<TopicProvider>();
    final topics = topicProvider.topics.where((t) => t.category.id == category.id);

    return Scaffold(
      drawer: Drawer(child: DrawerContent()),
      body: SafeArea(
        child: topics.isEmpty
            ? ListView(
              children: [
                Header(title: category.name),
                Center(child: Text('No Topics found'))
              ],
            )
            : ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Header(title: category.name),
                  ...topics.map(
                    (t) => TopicCard(
                      topic: t,
                      onDeleted: () async {
                        await topicProvider.removeTopic(t);
                      },
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: MultiFunctionFloatingButton(),
    );
  }
}