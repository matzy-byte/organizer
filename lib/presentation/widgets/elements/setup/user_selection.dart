import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/app/routes.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:provider/provider.dart';

class UserSelection extends StatelessWidget {
  const UserSelection({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    if (userProvider.users.isEmpty) {
      userProvider.loadAllUsers();
    }
    return Row(
      children: [
        ...userProvider.users.map((u) => TextButton(onPressed: () {
          globals.user = u;
          Navigator.pushNamed(context, AppRoutes.dashboard);
        }, child: Text(u.name)))
      ],
    );
  }
  
}