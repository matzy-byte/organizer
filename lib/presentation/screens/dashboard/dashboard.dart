import 'package:flutter/material.dart';
import 'package:organizer/presentation/screens/dashboard/widgets/chart_card.dart';
import 'package:organizer/presentation/screens/dashboard/widgets/header.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                "Categories",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(leading: Icon(Icons.dashboard), title: Text("Dashboard")),
            ListTile(leading: Icon(Icons.settings), title: Text("data")),
            ListTile(leading: Icon(Icons.plus_one), title: Text("Add"), onTap: () => addCategory())
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DashboardHeader(title: "Dashboard"),
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
    );
  }

  void addCategory() {

  }
}
