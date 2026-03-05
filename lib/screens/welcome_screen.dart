import 'package:chat_app/screens/settings.dart';
import 'package:chat_app/widgets/main_dreawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/providers/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chat_app/providers/theme_provider.dart';

class AppActions {
  // We use a static method so we can pass the context in!
  static List<Widget> getSettingsActions(BuildContext context, bool isDark,
      Function() onToggle, void Function() onPressedSettings) {
    return [
      PopupMenuButton(
        itemBuilder: (ctx) => [
          PopupMenuItem(
            onTap: onToggle,
            child: const Text('log out'),
          ),
          PopupMenuItem(
            onTap: onPressedSettings,
            child: const Text('settings'),
          )
        ],
      ),
    ];
  }
}

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});
  @override
  ConsumerState<WelcomeScreen> createState() {
    return _WelcomeScreen();
  }
}

class _WelcomeScreen extends ConsumerState<WelcomeScreen> {
  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const SettingsScreen()),
    );
  }

  void _logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemProvider);
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        elevation: 0, // Flat app bar looks more modern
        actions: AppActions.getSettingsActions(
          context,
          isDark,
          _logOut,
          _openSettings,
        ),
      ),
      drawer: const MainDrawer(),
      // REMOVED Expanded from here, added Padding for breathing room
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8, // Slightly taller cards
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length, // Use items.length instead of hardcoded 2
        itemBuilder: (ctx, index) {
          final item = items[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => item.screen),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // IMAGE PART - Fixed height and fit
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.cover, // Forces image to fill the area
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ),
                  // DESCRIPTION PART
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
