import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/widgets/elements/setup/sub_elements/user_circle_tile.dart';
import 'package:provider/provider.dart';

class UserSelection extends StatelessWidget {
  const UserSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final setupTheme = Theme.of(context).extension<SetupTheme>()!;

    if (userProvider.users.isEmpty) {
      userProvider.loadAllUsers();
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: setupTheme.sectionSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: userProvider.users
              .map(
                (u) => UserCircleTile(
                  user: u,
                  onTap: () {
                    globals.user = u;
                    Navigator.pushNamed(context, AppRoutes.dashboard);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
