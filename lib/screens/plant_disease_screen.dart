import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class PlantDiseaseScreen extends StatefulWidget {
  const PlantDiseaseScreen({super.key});

  @override
  State<PlantDiseaseScreen> createState() {
    return _PlantDiseaseScreen();
  }
}

class _PlantDiseaseScreen extends State<PlantDiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Disease'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => const [
              PopupMenuItem(
                value: 'item 1',
                child: Text('item 1'),
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: MyImagePicker(),
      ),
    );
  }
}
