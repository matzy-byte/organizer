import 'package:flutter/material.dart';
import 'package:organizer/app/themes/setup_theme_extension.dart';

class SetupItemRow extends StatelessWidget {
  final String text;
  final VoidCallback onDelete;

  const SetupItemRow({super.key, required this.text, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SetupTheme>()!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.itemSpacing / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
    );
  }
}
