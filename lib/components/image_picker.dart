import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gstock/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(String imageFileBase64) callback;
  final bool isEdit,isUserImage;
  final String imageFileBase64;
  const ImagePickerWidget(
      {Key? key,
      required this.callback,
      this.isEdit = false,
      this.imageFileBase64 = "",
      this.isUserImage = true
      })
      : super(key: key);

  @override
  ImagePickerState createState() => ImagePickerState();
}

class ImagePickerState extends State<ImagePickerWidget> {
  String? imageFileBase64;
  final _selectImageController = TextEditingController();
  @override
  void initState() {
    setState(() {
      if(widget.isEdit) {
        imageFileBase64 = widget.imageFileBase64;
        _selectImageController.text = "Try Edit your Photo";
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            foregroundColor: Colors.transparent,
            backgroundImage: imageFileBase64!=null ? MemoryImage(base64Decode(imageFileBase64!))
                    : AssetImage(widget.isUserImage?'assets/images/user.png':'assets/images/addimage.png') as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: kPrimaryColor,
                  child: Icon(
                    widget.isEdit ?  Icons.edit:Icons.add_a_photo ,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              ),
            ),
          ),
        ]),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.3,),
          child: TextFormField(
            controller: _selectImageController,
            readOnly: true,
            showCursor: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose a photo';
              }
              return null;
            },
            style:TextStyle(color: widget.isEdit ? Colors.amberAccent: Colors.green),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
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
            "Choose a photo",
            style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
                icon: const Icon(
                  Icons.camera,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: const Text(
                  "Camera",
                  style: TextStyle(color: kPrimaryColor),
                )),
            TextButton.icon(
              icon: const Icon(
                Icons.image,
                color: kPrimaryColor,
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text(
                "Gallery",
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    File? _imageFile;
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;
    setState(() {
      _imageFile = File(pickedFile.path);
      imageFileBase64 = base64Encode(_imageFile!.readAsBytesSync());
      widget.callback(imageFileBase64!);
      _selectImageController.text = "Photo add Successful";
    });
  }
}
