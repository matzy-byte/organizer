import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_fix_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_topic_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_var_transaction_dialog.dart';
import 'package:provider/provider.dart';

class MultiFunctionFloatingButton extends StatelessWidget {
  final Category? category;
  final Topic? topic;
  final VoidCallback? addedFixTransaction;
  final VoidCallback? addedVarTransaction;
  const MultiFunctionFloatingButton({
    super.key,
    this.category,
    this.topic,
    this.addedFixTransaction,
    this.addedVarTransaction,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<CategoryProvider>();
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
          onTap: () => showDialog(
            context: context,
            builder: (context) => AddCategoryDialog(),
          ),
        ),
        SpeedDialChild(
          child: Icon(Icons.table_chart),
          label: 'Add Topic',
          onTap: () async {
            showDialog(
              context: context,
              builder: (context) => AddTopicDialog(
                category:
                    category ??
                    categoryProvider.categories
                        .where((c) => c.id == topic?.categoryId)
                        .cast<Category?>()
                        .firstOrNull,
              ),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.slideshow),
          label: 'Add Fix Transaction',
          onTap: () async {
            final updated = await showDialog(
              context: context,
              builder: (context) => AddFixTransactionDialog(
                category:
                    category ??
                    categoryProvider.categories
                        .where((c) => c.id == topic?.categoryId)
                        .cast<Category?>()
                        .firstOrNull,
              ),
            );

            if (updated == true) {
              addedFixTransaction?.call();
            }
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.slideshow),
          label: 'Add Var Transaction',
          onTap: () async {
            final updated = await showDialog<bool>(
              context: context,
              builder: (context) => AddVarTransactionDialog(
                category:
                    category ??
                    categoryProvider.categories
                        .where((c) => c.id == topic?.categoryId)
                        .cast<Category?>()
                        .firstOrNull,
                topic: topic,
              ),
            );

            if (updated == true) {
              addedVarTransaction?.call();
            }
          },
        ),
      ],
    );
  }
}
