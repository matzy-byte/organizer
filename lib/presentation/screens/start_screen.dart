import 'package:flutter/material.dart';
import 'package:organizer/presentation/widgets/elements/setup/user_selection.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: const UserSelection()));
  }
}
