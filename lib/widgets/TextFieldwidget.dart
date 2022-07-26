import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final int maxLines;
  final ValueChanged<String> onChanged;

  const TextFieldWidget(
      {Key? key,
      required this.label,
      required this.text,
      required this.onChanged,
      this.maxLines = 1})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: GoogleFonts.poppins(color: Colors.grey),
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}
