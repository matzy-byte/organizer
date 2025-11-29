import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/app/routes.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/elements/options/options_element.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_element.dart';
import 'package:organizer/presentation/widgets/elements/users/user_icon.dart';
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

    from = globals.from;
    to = globals.to;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VarTransactionProvider>().load(from: from, to: to);
    });
  }

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const Drawer(child: DrawerContent()),
      appBar: AppBar(
        title: Text(
          at.dashboard,
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
          PopupMenuButton<String>(
            icon: const Icon(Icons.sync),
            tooltip: 'synching',
            onSelected: (value) {
              if (value == 'update') {
                // update repeated transactions
              } else if (value == 'sync') {
                // sync devices
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'update',
                child: Text("Update repeated transactions"),
              ),
              const PopupMenuItem(value: 'sync', child: Text("Sync devices")),
            ],
          ),
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
