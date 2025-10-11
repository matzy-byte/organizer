import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_topic_dialog.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:organizer/presentation/widgets/topic_card.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category? _category;
  List<Topic> _topics = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newCategory = ModalRoute.of(context)!.settings.arguments as Category;
    if (_category != newCategory) {
      _category = newCategory;
      _loadTopics();
    }
  }

  Future<void> _loadTopics() async {
    if (_category == null) return;
    setState(() => _isLoading = true);
    final topicProvider = context.read<TopicProvider>();
    final topics = await topicProvider.loadTopicsByCategory(_category!);
    setState(() {
      _topics = topics;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: DrawerContent()),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _topics.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return Header(title: _category!.name);
                  final topic = _topics[index - 1];
                  return TopicCard(
                    topic: topic,
                    onDeleted: () async {
                      await context.read<TopicProvider>().removeTopic(topic);
                      _loadTopics();
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) => AddTopicDialog(category: _category!),
          );
          _loadTopics();
        },
      ),
    );
  }
}
