import 'package:flutter/material.dart';
import 'package:organizer/core/models/user.dart';
import 'package:organizer/core/utils/color_util.dart';

class UserIcon extends StatelessWidget {
  final User user;
  final double size;
  const UserIcon({super.key, required this.user, required this.size});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: user.name,
      child: CircleAvatar(
        radius: size,
        backgroundColor: ColorUtil.colorFromHexCode(user.color),
        child: Text(
          user.name[0].toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
