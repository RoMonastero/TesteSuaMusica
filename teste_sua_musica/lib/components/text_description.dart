import 'package:flutter/material.dart';

class TextDescription extends StatelessWidget {
  final List contents;
  final String contentType;

  const TextDescription(
      {Key? key, required this.contents, required this.contentType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String contentsName = '';
    for (var content in contents) {
      contentsName += '${content.name}, ';
    }

    contentsName = contentsName.substring(0, contentsName.length - 2);
    return Text(
      '$contentType: $contentsName',
      style: const TextStyle(fontSize: 16),
    );
  }
}
