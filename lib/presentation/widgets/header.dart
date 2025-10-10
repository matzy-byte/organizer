import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';

class Header extends StatelessWidget {
  final String title;
  
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => selectSettings(context),
        ),
      ],
    );
  }

  void selectSettings(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settings);
  }
}
