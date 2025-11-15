import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/elements/options/options_element.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_element.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:organizer/presentation/widgets/multi_function_floating_button.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DateTime from;
  late DateTime to;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    to = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final monthAgo = DateTime(now.year, now.month - 1, now.day);
    from = DateTime(monthAgo.year, monthAgo.month, monthAgo.day, 0, 0, 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VarTransactionProvider>().load(from: from, to: to);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: DrawerContent()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(title: 'Dashboard'),
              OptionsElement(
                fromDate: from,
                toDate: to,
                onFilterChanged: (newFrom, newTo) {
                  setState(() {
                    from = newFrom;
                    to = newTo;
                  });
                  context.read<VarTransactionProvider>().load(
                    from: from,
                    to: to,
                  );
                },
              ),

              const SizedBox(height: 12),
              OverviewElement(isDashboard: true),
            ],
          ),
        ),
      ),
      floatingActionButton: const MultiFunctionFloatingButton(),
    );
  }
}
