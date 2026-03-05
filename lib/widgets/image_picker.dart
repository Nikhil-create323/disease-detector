// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class MyImagePicker extends StatefulWidget {
//   const MyImagePicker({super.key});

//   @override
//   State<MyImagePicker> createState() {
//     return _ImagePickerState();
//   }
// }

// class _ImagePickerState extends State<MyImagePicker> {
//   File? _pickedImage;

//   void _pickImage() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedImage == null) return;

//     setState(() {
//       _pickedImage = File(pickedImage.path);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Container(
//         decoration: BoxDecoration(
//             border: BoxBorder.all(color: Theme.of(context).colorScheme.primary),
//             borderRadius: BorderRadius.circular(15)),
//         alignment: Alignment.center,
//         height: 600,
//         width: 400,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 60,
//               backgroundImage:
//                   _pickedImage == null ? null : FileImage(_pickedImage!),
//             ),
//             const SizedBox(height: 8),
//            ElevatedButton.icon(
//               onPressed: _pickImage,
//               icon: const Icon(Icons.image),
//               label: const Text('Add Image'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<MyImagePicker> {
  File? _pickedImage;

  // 1. Refactor: Accept the source (Camera or Gallery) as an argument
  void _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage == null) return;

    setState(() {
      _pickedImage = File(pickedImage.path);
    });
  }

  // 2. New Method: Show a bottom sheet to choose between Camera and Gallery
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the sheet
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the sheet
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Helper variable to check if an image is currently selected
    final bool isImageSelected = _pickedImage != null;

    return Card(
      child: Container(
        decoration: BoxDecoration(
            // Note: Fixed BoxBorder.all to Border.all
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        height: 500,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage:
                  isImageSelected ? FileImage(_pickedImage!) : null,
              // Optional: Add a default icon if no image is selected
              child:
                  !isImageSelected ? const Icon(Icons.person, size: 60) : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showImageSourceOptions,
              icon: Icon(isImageSelected ? Icons.edit : Icons.image),
              label: Text(isImageSelected ? 'Change Image' : 'Add Image'),
            ),
            const SizedBox(
              height: 20,
            ),

            ElevatedButton(onPressed: () {}, child: const Text('Predict Disease'))
          ],
        ),
      ),
    );
  }
}
