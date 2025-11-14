import 'package:flutter/material.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/elements/options/options_element.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_element.dart';
import 'package:organizer/presentation/widgets/elements/var_transactions/var_transaction_element.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:organizer/presentation/widgets/multi_function_floating_button.dart';
import 'package:provider/provider.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({super.key});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  late DateTime from;
  late DateTime to;
  Topic? lastTopic;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    to = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final monthAgo = DateTime(now.year, now.month - 1, now.day);
    from = DateTime(monthAgo.year, monthAgo.month, monthAgo.day, 0, 0, 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;

    if (topic != lastTopic) {
      lastTopic = topic;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<VarTransactionProvider>().load(
          topicId: topic.id,
          from: from,
          to: to,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;

    return Scaffold(
      drawer: const Drawer(child: DrawerContent()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: topic.name),
              OptionsElement(
                fromDate: from,
                toDate: to,
                onFilterChanged: (newFrom, newTo) {
                  setState(() {
                    from = newFrom;
                    to = newTo;
                  });
                  context.read<VarTransactionProvider>().load(
                    topicId: topic.id,
                    from: from,
                    to: to,
                  );
                },
              ),
              const SizedBox(height: 12),
              OverviewElement(),
              const SizedBox(height: 12),
              VarTransactionElement(),
            ],
          ),
        ),
      ),
      floatingActionButton: MultiFunctionFloatingButton(topic: topic),
    );
  }
}
