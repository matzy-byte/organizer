import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:provider/provider.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProvider>();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blueAccent),
          child: Text(
            'Categories',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Dashboard'),
          onTap: () => selectDashboard(context),
        ),
        ...List.generate(provider.categories.length, (index) {
          final cat = provider.categories[index];
          return ListTile(
            leading: Icon(Icons.access_alarm),
            title: Text(cat.name),
            onTap: () => selectCategory(context, cat),
          );
        }),
      ],
    );
  }

  void selectDashboard(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dashboard);
  }

  void selectCategory(BuildContext context, Category cat) {
    Navigator.pushNamed(context, AppRoutes.category, arguments: cat);
  }
}
