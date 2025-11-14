import 'package:flutter/material.dart';
import 'package:organizer/app/themes/setup_theme_extension.dart';

class SetupSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onAdd;

  const SetupSection({
    super.key,
    required this.title,
    required this.children,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SetupTheme>()!;

    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: theme.itemSpacing),
        ...children,
        if (onAdd != null) ...[
          SizedBox(height: theme.itemSpacing),
          IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
        ],
      ],
    );
  }
}
