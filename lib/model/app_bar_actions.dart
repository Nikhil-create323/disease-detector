import 'package:flutter/material.dart';

// Use a function so it can accept the current brightness and a callback
List<Widget> getGlobalActions(
    BuildContext context, bool isDarkMode, Function(bool) onThemeChanged) {
  return [
    ListTile(
      title: const Text('Log out'),
      trailing: const Icon(Icons.exit_to_app),
      onTap: () {
        // Add your logout logic here
        print("User logged out");
      },
    ),
    SwitchListTile(
      title: const Text('Dark Mode'),
      value: isDarkMode,
      onChanged: (bool value) {
        onThemeChanged(value);
      },
    ),
  ];
}
