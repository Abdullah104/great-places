import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File) imageSelector;

  const ImageInput({
    Key? key,
    required this.imageSelector,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage == null
              ? const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: TextButton.icon(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: _takeImage,
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
          ),
        ),
      ],
    );
  }

  void _takeImage() {
    ImagePicker()
        .pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    )
        .then((imageFile) {
      setState(() {
        if (imageFile == null) {
          _storedImage = null;
        } else {
          _storedImage = File(imageFile.path);

          widget.imageSelector(_storedImage!);
        }
      });
    });
  }
}
