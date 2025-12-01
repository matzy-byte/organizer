import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_user_dialog.dart';
import 'package:organizer/presentation/widgets/elements/setup/sub_elements/setup_item_row.dart';
import 'package:organizer/presentation/widgets/elements/setup/sub_elements/setup_section.dart';
import 'package:provider/provider.dart';

class UserSetup extends StatelessWidget {
  const UserSetup({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return SetupSection(
      title: 'Users',
      onAdd: () =>
          showDialog(context: context, builder: (_) => const AddUserDialog()),
      children: userProvider.users
          .map(
            (u) => SetupItemRow(
              text: u.name,
              onDelete: () => userProvider.removeUser(u.id),
            ),
          )
          .toList(),
    );
  }
}
