import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/presentation/widgets/elements/setup/structure_setup.dart';
import 'package:organizer/presentation/widgets/elements/setup/user_setup.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserSetup(),
          StructureSetup(),
          TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.dashboard), child: Text('Okay'))
        ],
      ),
    );
  }

}