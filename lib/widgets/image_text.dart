// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:image_editor_app/models/text_info.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({
    Key? key,
    required this.textInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
        fontSize: textInfo.fontSize,
        fontStyle: textInfo.fontStyle,
        fontWeight: textInfo.fontWeight,
        color: textInfo.color,
      ),
    );
  }
}
