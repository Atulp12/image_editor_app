import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editor_app/models/text_info.dart';
import 'package:image_editor_app/screens/edit_screen.dart';
import 'package:image_editor_app/utils/utils.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditViewModel extends State<EditScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorController = TextEditingController();
  TextInfo? text;
  XFile? file1;
  String? filePath;
  ScreenshotController screenshotController = ScreenshotController();

  setCurrent(context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Selected for Styling',
      style: TextStyle(fontSize: 16),
    )));
  }

  changeTextColor(Color color) {
    setState(() {
      text!.color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      text!.fontSize = text!.fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      text!.fontSize = text!.fontSize -= 2;
    });
  }

  changeAlignment(TextAlign align) {
    setState(() {
      text!.textAlign = align;
    });
  }

  changeFontStyle() {
    setState(() {
      if (text!.fontStyle == FontStyle.italic) {
        text!.fontStyle = FontStyle.normal;
      } else {
        text!.fontStyle = FontStyle.italic;
      }
    });
  }

  changeFontWeight() {
    setState(() {
      if (text!.fontWeight == FontWeight.bold) {
        text!.fontWeight = FontWeight.normal;
      } else {
        text!.fontWeight = FontWeight.bold;
      }
    });
  }

  saveToGallery(BuildContext context) {
    if (text != null) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to Gallery!'),
          ),
        );
      }).catchError((err) {
        debugPrint(err);
      });
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "editedImage_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  addNewText(BuildContext context) {
    setState(() {
      text = TextInfo(
          text: textEditingController.text,
          color: Colors.black,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
          top: 0,
          left: 0,
          textAlign: TextAlign.start);
      filePath = file1!.path;
      Navigator.pop(context);
    });
  }

  addDialogBox(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Logo and Text"),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Text('Pick Logo : '),
                          TextButton(
                            onPressed: () async {
                              XFile? file = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              if (file != null) {
                                // ignore: use_build_context_synchronously
                                file1 = file;
                              }
                            },
                            child: file1 != null
                                ? const Text("Logo Picked!")
                                : const Text('Choose Logo'),
                          )
                        ],
                      ),
                    ),
                    TextField(
                      controller: textEditingController,
                      decoration:
                          const InputDecoration(hintText: "Your Text here.."),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => addNewText(context),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ));
  }
}
