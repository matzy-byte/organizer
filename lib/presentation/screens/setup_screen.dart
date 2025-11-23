import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/widgets/elements/setup/structure_setup.dart';
import 'package:organizer/presentation/widgets/elements/setup/user_setup.dart';
import 'package:provider/provider.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final setupTheme = Theme.of(context).extension<SetupTheme>()!;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: setupTheme.cardMaxWidth),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: setupTheme.cardPadding,
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Setup',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        const UserSetup(),
                        SizedBox(height: setupTheme.sectionSpacing),

                        const StructureSetup(),
                        SizedBox(height: setupTheme.sectionSpacing),

                        ElevatedButton(
                          onPressed: () {
                            if (context.read<UserProvider>().users.isEmpty) {
                              return;
                            }
                            Navigator.pushNamed(context, AppRoutes.start);
                          },
                          child: const Text('Finish Setup'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
