import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_user_dialog.dart';
import 'package:provider/provider.dart';

class UserSetup extends StatelessWidget {
  const UserSetup({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    return Card(
      child: Column(
        children: [
          Text('Users'),
          ...userProvider.users.map(
            (u) => Row(
              children: [
                Text(u.name),
                IconButton(onPressed: () async {
                  await userProvider.removeUser(u.id);
                }, icon: Icon(Icons.delete)),
              ],
            ),
          ),
          IconButton(onPressed: () async {
            await showDialog(context: context, builder: (context) => AddUserDialog());
          }, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
