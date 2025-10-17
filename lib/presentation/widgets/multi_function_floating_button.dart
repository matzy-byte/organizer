import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_fix_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_topic_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_var_transaction_dialog.dart';

class MultiFunctionFloatingButton extends StatelessWidget {
  final Category? category;
  final Topic? topic;
  const MultiFunctionFloatingButton({super.key, this.category, this.topic});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      children: [
        SpeedDialChild(
          child: Icon(Icons.description),
          label: 'Add Category',
          onTap: () => showDialog(context: context, builder: (context) => AddCategoryDialog()),
        ),
        SpeedDialChild(
          child: Icon(Icons.table_chart),
          label: 'Add Topic',
          onTap: () => showDialog(context: context, builder: (context) => AddTopicDialog(category: category ?? topic?.category,)),
        ),
        SpeedDialChild(
          child: Icon(Icons.slideshow),
          label: 'Add Fix Transaction',
          onTap: () => showDialog(context: context, builder: (context) => AddFixTransactionDialog(category: category ?? topic?.category, topic: topic,)),
        ),
        SpeedDialChild(
          child: Icon(Icons.slideshow),
          label: 'Add Var Transaction',
          onTap: () => showDialog(context: context, builder: (context) => AddVarTransactionDialog(category: category ?? topic?.category, topic: topic,)),
        ),
      ],
    );
  }
}
