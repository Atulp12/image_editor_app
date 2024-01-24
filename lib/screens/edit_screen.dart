// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor_app/widgets/edit_model.dart';
import 'package:image_editor_app/widgets/image_text.dart';
import 'package:screenshot/screenshot.dart';

class EditScreen extends StatefulWidget {
  final String selectedFile;
  const EditScreen({super.key, required this.selectedFile});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends EditViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              _getImage,
              if (text != null)
                Positioned(
                  left: text!.left,
                  top: text!.top,
                  child: GestureDetector(
                    onTap: () => setCurrent(context),
                    child: Draggable(
                      feedback: ImageText(textInfo: text!),
                      child: ImageText(textInfo: text!),
                      onDragEnd: (drag) {
                        final renderBox = context.findRenderObject() as RenderBox;
                        Offset off = renderBox.globalToLocal(drag.offset);
                        setState(() {
                          text!.top = off.dy - 96;
                          text!.left = off.dx;
                        });
                      },
                    ),
                  ),
                ),
              creatorController.text.isNotEmpty
                  ? Positioned(
                      child: Text(
                        creatorController.text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              if(filePath != null)
              Positioned(
                left: 20,
                top: 20,
                child: CircleAvatar(
                  child: Image.file(
                    File(filePath!),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
      floatingActionButton: _addLogoText,
    );
  }

  Widget get _getImage => Center(
        child: Image.file(
          File(widget.selectedFile),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );

  Widget get _addLogoText => FloatingActionButton(
        onPressed: () => addDialogBox(context),
        backgroundColor: Colors.white,
        tooltip: "Add Logo & Text",
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: () => saveToGallery(context),
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                tooltip: 'Save Image',
              ),
              IconButton(
                onPressed: () => increaseFontSize(),
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                tooltip: 'Increase Font Size',
              ),
              IconButton(
                onPressed: () => decreaseFontSize(),
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                tooltip: 'Decrease Font Size',
              ),
              // IconButton(
              //   onPressed: () => changeAlignment(TextAlign.left),
              //   icon: const Icon(
              //     Icons.format_align_left,
              //     color: Colors.black,
              //   ),
              //   tooltip: 'Align Left',
              // ),
              // IconButton(
              //   onPressed: () => changeAlignment(TextAlign.center),
              //   icon: const Icon(
              //     Icons.format_align_center,
              //     color: Colors.black,
              //   ),
              //   tooltip: 'Align Center',
              // ),
              // IconButton(
              //   onPressed: () => changeAlignment(TextAlign.right),
              //   icon: const Icon(
              //     Icons.format_align_right,
              //     color: Colors.black,
              //   ),
              //   tooltip: 'Align Right',
              // ),
              IconButton(
                onPressed: () => changeFontWeight(),
                icon: const Icon(
                  Icons.format_bold,
                  color: Colors.black,
                ),
                tooltip: 'Bold',
              ),
              IconButton(
                onPressed: () => changeFontStyle(),
                icon: const Icon(
                  Icons.format_italic,
                  color: Colors.black,
                ),
                tooltip: 'Italic',
              ),

              Tooltip(
                message: 'Black',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),

              Tooltip(
                message: 'Red',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Blue',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Yellow',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Green',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Orange',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Pink',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );
}
