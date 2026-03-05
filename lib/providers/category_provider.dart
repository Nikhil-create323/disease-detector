import 'package:chat_app/model/ListItem.dart';
import 'package:chat_app/screens/gastrovision.dart';
import 'package:chat_app/screens/plant_disease_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProvider extends Notifier<List<GridItem>> {
  void removeCategory(GridItem newCategory) {
    state = state.where((item) => item != newCategory).toList();
  }

  void addCategory(GridItem newCategory) {
    state = [...state, newCategory];
  }

  static final List<GridItem> _categoryOfDisease = [
    GridItem(
      title: 'Plant Disease',
      imagePath: 'assets/images/plant.jpeg',
      screen: const PlantDiseaseScreen(),
      tileColor: Colors.green.shade50
    ),
    GridItem(
      title: 'Digestive Disease',
      imagePath: 'assets/images/digestive_system.png',
      screen: const GastrovisionScreen(),
      tileColor: Colors.orange.shade50
    )
  ];

  @override
  List<GridItem> build() {
    return _categoryOfDisease;
  }
}

final itemProvider = NotifierProvider<CategoryProvider, List<GridItem>>(
  CategoryProvider.new,
);
