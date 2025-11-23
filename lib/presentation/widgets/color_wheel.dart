import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorWheelDialog extends StatefulWidget {
  final Color color;
  const ColorWheelDialog({super.key, required this.color});

  @override
  State<ColorWheelDialog> createState() => _ColorWheelDialog();
}

class _ColorWheelDialog extends State<ColorWheelDialog> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();

    _selectedColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: ColorPickerHueRing(
                HSVColor.fromColor(_selectedColor),
                (color) => setState(() => _selectedColor = color.toColor()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _selectedColor);
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
