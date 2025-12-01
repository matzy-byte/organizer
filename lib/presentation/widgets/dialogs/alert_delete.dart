import 'package:flutter/material.dart';
import 'package:organizer/l10n/app_localizations.dart';

class AlertDelete extends StatelessWidget {
  final String type;
  final String value;

  const AlertDelete({super.key, required this.type, required this.value});

  static Future<bool> show(
    BuildContext context, {
    required String type,
    required String value,
  }) async {
    bool? val = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDelete(type: type, value: value),
    );
    if (val == true) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text('${at.delete} $type?'),
      content: Text(at.shureDelete(value)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(at.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(at.delete),
        ),
      ],
    );
  }
}
