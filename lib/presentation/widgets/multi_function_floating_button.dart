import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_fix_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_topic_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_user_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_var_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/manage_transaction_labels_dialog.dart';

class MultiFunctionFloatingButton extends StatefulWidget {
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
  State<MultiFunctionFloatingButton> createState() =>
      _MultiFunctionFloatingButtonState();
}

class _MultiFunctionFloatingButtonState
    extends State<MultiFunctionFloatingButton>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            onTap();
            _toggle();
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(label, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    
    final actions = <Widget>[
      _buildActionButton(
        icon: Icons.person,
        label: '${at.add} ${at.user}',
        onTap: () =>
            showDialog(context: context, builder: (_) => AddUserDialog()),
      ),
      _buildActionButton(
        icon: Icons.label,
        label: '${at.manage} ${at.transaction} ${at.label}',
        onTap: () => showDialog(
          context: context,
          builder: (_) => ManageTransactionLabelsDialog(),
        ),
      ),
      _buildActionButton(
        icon: Icons.description,
        label: '${at.add} ${at.category}',
        onTap: () => showDialog(
          context: context,
          builder: (_) => const AddCategoryDialog(),
        ),
      ),
      _buildActionButton(
        icon: Icons.table_chart,
        label: '${at.add} ${at.topic}',
        onTap: () => showDialog(
          context: context,
          builder: (_) => AddTopicDialog(category: widget.category),
        ),
      ),
      _buildActionButton(
        icon: Icons.schedule,
        label: '${at.add} ${at.repeated} ${at.transaction}',
        onTap: () async {
          final updated = await showDialog(
            context: context,
            builder: (_) => AddFixTransactionDialog(
              category: widget.category,
              topic: widget.topic,
            ),
          );
          if (updated == true) widget.addedFixTransaction?.call();
        },
      ),
      _buildActionButton(
        icon: Icons.event,
        label: '${at.add} ${at.transaction}',
        onTap: () async {
          final updated = await showDialog<bool>(
            context: context,
            builder: (_) => AddVarTransactionDialog(
              category: widget.category,
              topic: widget.topic,
            ),
          );
          if (updated == true) widget.addedVarTransaction?.call();
        },
      ),
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Expanded action panel
        Positioned(
          bottom: 70,
          right: 16,
          child: FadeTransition(
            opacity: _controller,
            child: ScaleTransition(
              scale: _controller,
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: actions,
              ),
            ),
          ),
        ),

        // Floating main button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  RotationTransition(turns: anim, child: child),
              child: _open
                  ? const Icon(Icons.close, key: ValueKey('close'))
                  : const Icon(Icons.add, key: ValueKey('add')),
            ),
          ),
        ),
      ],
    );
  }
}
