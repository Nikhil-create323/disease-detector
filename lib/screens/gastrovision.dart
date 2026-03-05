import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class GastrovisionScreen extends StatefulWidget {
  const GastrovisionScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GastrovisionScreen();
  }
}

class _GastrovisionScreen extends State<GastrovisionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastrovision'),
        actions: [PopupMenuButton(itemBuilder: (ctx)=> const [PopupMenuItem(value: 'item 1',child: Text('item 1'),)])],
      ),
      body: const Center(child: MyImagePicker()),
    );
  }
}
