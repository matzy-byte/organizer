import 'package:flutter/material.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/elements/fix_transaction_element.dart';
import 'package:organizer/presentation/widgets/header.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;

    return Scaffold(
      drawer: Drawer(child: DrawerContent()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: topic.name),
              FixTransactionElement()
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        children: [
          SpeedDialChild(
            child: Icon(Icons.description),
            label: 'Create Doc',
            onTap: () => print('Create Doc'),
          ),
          SpeedDialChild(
            child: Icon(Icons.table_chart),
            label: 'Create Sheet',
            onTap: () => print('Create Sheet'),
          ),
          SpeedDialChild(
            child: Icon(Icons.slideshow),
            label: 'Create Slide',
            onTap: () => print('Create Slide'),
          ),
        ],
      ),
    );
  }
}
