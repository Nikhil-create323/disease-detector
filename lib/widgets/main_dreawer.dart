import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
            decoration: BoxDecoration(
            // border: BorderRadius.circular(),
                gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.shade300],
                    begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: const Center(),
          ))
        ],
      ),
    );
  }
}
