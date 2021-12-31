import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  ImagePickerState createState() => ImagePickerState();
}

class ImagePickerState extends State<ImagePickerWidget> {

  File? _imageFile;
  final _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return imageProfile();
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null ? const AssetImage('assets/images/user.png'):FileImage(_imageFile!) as ImageProvider,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.red,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null ) return;
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
}