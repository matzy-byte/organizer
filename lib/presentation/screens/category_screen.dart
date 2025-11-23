import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/core/models/category.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/elements/options/options_element.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_element.dart';
import 'package:organizer/presentation/widgets/elements/topics/topic_element.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:organizer/presentation/widgets/multi_function_floating_button.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late DateTime from;
  late DateTime to;
  Category? lastCategory;

  @override
  void initState() {
    super.initState();
    
    from = globals.from;
    to = globals.to;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    if (category != lastCategory) {
      lastCategory = category;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<TopicProvider>().loadAllTopics();
        context.read<VarTransactionProvider>().loadByCategory(
          categoryId: category.id,
          from: from,
          to: to,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      drawer: const Drawer(child: DrawerContent()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: category.name),
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
                  context.read<VarTransactionProvider>().loadByCategory(
                    categoryId: category.id,
                    from: from,
                    to: to,
                  );
                },
              ),
              const SizedBox(height: 12),
              OverviewElement(),
              const SizedBox(height: 12),
              TopicElement(categoryId: category.id,),
            ],
          ),
        ),
      ),
      floatingActionButton: MultiFunctionFloatingButton(category: category),
    );
  }
}
