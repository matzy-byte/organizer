import 'package:flutter/material.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/elements/fix_transactions/fix_transaction_element.dart';
import 'package:organizer/presentation/widgets/elements/var_transactions/var_transaction_element.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:organizer/presentation/widgets/multi_function_floating_button.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    final GlobalKey<FixTransactionElementState> fixTransactionElementKey =
        GlobalKey();
    final GlobalKey<VarTransactionElementState> varTransactionElementKey =
        GlobalKey();

    return Scaffold(
      drawer: Drawer(child: DrawerContent()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: topic.name),
              FixTransactionElement(key: fixTransactionElementKey),
              VarTransactionElement(key: varTransactionElementKey),
            ],
          ),
        ),
      ),
      floatingActionButton: MultiFunctionFloatingButton(
        topic: topic,
        addedFixTransaction: () =>
            fixTransactionElementKey.currentState?.loadFixTransactions(),
        addedVarTransaction: () =>
            varTransactionElementKey.currentState?.loadVarTransactions(),
      ),
    );
  }
}
