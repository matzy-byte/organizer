import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as global;
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/widgets/category_tile.dart';
import 'package:organizer/presentation/widgets/multi_function_floating_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLocale = global.locale.value.languageCode;

  Future<void> _saveLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
    global.locale.value = Locale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ...provider.categories.map((c) => CategoryTile(category: c)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text('Localization: '),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedLocale,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLocale = value;
                      });
                      _saveLocale(value);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const MultiFunctionFloatingButton(),
    );
  }
}
