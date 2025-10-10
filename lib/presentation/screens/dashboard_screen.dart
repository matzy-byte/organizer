import 'package:flutter/material.dart';
import 'package:organizer/presentation/widgets/chart_card.dart';
import 'package:organizer/presentation/widgets/drawer_content.dart';
import 'package:organizer/presentation/widgets/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerContent(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Header(title: 'Dashboard'),
              SizedBox(height: 24),
              ChartCard(
                title: 'Aktivität',
                value: '70%',
                subtitle: 'Diese Woche',
              ),
              SizedBox(height: 16),
              ChartCard(
                title: 'Einnahmen',
                value: '€ 1.230',
                subtitle: 'Letzter Monat',
              ),
              SizedBox(height: 16),
              ChartCard(title: 'Verlauf', value: '+15%', subtitle: 'Trend'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Dialog(),
        ),
      )
    );
  }
}
