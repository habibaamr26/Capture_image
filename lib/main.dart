import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ImageCaptureApp());
}

class ImageCaptureApp extends StatefulWidget {
  const ImageCaptureApp({super.key});

  @override
  _ImageCaptureAppState createState() => _ImageCaptureAppState();
}

class _ImageCaptureAppState extends State<ImageCaptureApp> {
  final List<File> _imageFile = [];

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile.add(File(pickedImage!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('Image Capture'),
        ),
        body: Center(
          child: _imageFile.isEmpty
              ? const Text('No image captured')
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyImages(imageFile: _imageFile),
              ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: _captureImage,
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}

class MyImages extends StatelessWidget {
  const MyImages({super.key, required this.imageFile});

  final List<File> imageFile;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
      ),
      itemCount: imageFile.length,
      itemBuilder: (context, index) {
        return Image.file(imageFile[index]);
      },
    );
  }
}