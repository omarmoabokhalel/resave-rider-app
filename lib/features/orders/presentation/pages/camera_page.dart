import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  final int orderItemId;

  const CameraPage({super.key, required this.orderItemId});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? imageFile;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void submitImage() {
    if (imageFile == null) return;

    // هنا ممكن تبعت الصورة للـ API
    // Example: Multipart POST
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم رفع الصورة بنجاح')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تصوير المخلفات')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (imageFile != null)
              Image.file(imageFile!, height: 250, fit: BoxFit.cover),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.camera),
              label: Text('التقاط صورة'),
              onPressed: pickImage,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('رفع الصورة'),
              onPressed: submitImage,
            ),
          ],
        ),
      ),
    );
  }
}
