import 'package:flutter/material.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/core/models/user.dart';

class UserCircleTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserCircleTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final setupTheme = theme.extension<SetupTheme>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        hoverColor: theme.colorScheme.primary.withOpacity(0.10),
        highlightColor: theme.colorScheme.primary.withOpacity(0.15),
        splashColor: theme.colorScheme.primary.withOpacity(0.25),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circle avatar
              Container(
                width: setupTheme.userAvatarSize,
                height: setupTheme.userAvatarSize,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    user.name.substring(0, 1).toUpperCase(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: setupTheme.userAvatarSize * 0.45,
                    ),
                  ),
                ),
              ),

              SizedBox(height: setupTheme.itemSpacing),

              // Username text (clickable because it's inside InkWell)
              Text(user.name, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
