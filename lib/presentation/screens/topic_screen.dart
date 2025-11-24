import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/app/routes.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/elements/fix_transactions/fix_transaction_element.dart';
import 'package:organizer/presentation/widgets/elements/options/options_element.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_element.dart';
import 'package:organizer/presentation/widgets/elements/users/user_icon.dart';
import 'package:organizer/presentation/widgets/elements/var_transactions/var_transaction_element.dart';
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

    from = globals.from;
    to = globals.to;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;

    if (topic != lastTopic) {
      lastTopic = topic;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<VarTransactionProvider>().loadByTopic(
          topicId: topic.id,
          from: from,
          to: to,
        );
        context.read<FixTransactionProvider>().loadByTopic(topic.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;

    return Scaffold(
      drawer: const Drawer(child: DrawerContent()),
      appBar: AppBar(
        title: Text(
          topic.name,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: UserIcon(user: globals.user, size: 20),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.start),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptionsElement(
                fromDate: from,
                toDate: to,
                onFilterChanged: (newFrom, newTo) {
                  globals.from = newFrom;
                  globals.to = newTo;
                  setState(() {
                    from = newFrom;
                    to = newTo;
                  });
                  context.read<VarTransactionProvider>().loadByTopic(
                    topicId: topic.id,
                    from: from,
                    to: to,
                  );
                },
              ),
              const SizedBox(height: 12),
              OverviewElement(),
              const SizedBox(height: 12),
              FixTransactionElement(),
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
