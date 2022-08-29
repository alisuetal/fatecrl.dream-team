import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'textfield_widget.dart';

class TextfieldWithLabelWidget extends StatelessWidget {
  final String hint;
  final void Function(String text) anchor;
  final String Function(String text)? validator;
  final keyboardtype;
  final String? text;
  final bool? obscure;

  const TextfieldWithLabelWidget(
      {Key? key,
      this.text,
      required this.anchor,
      required this.hint,
      this.obscure,
      this.keyboardtype,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color(0xffAAAAAA), fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextfieldWidget(
            anchor: (e) => anchor(e),
            hint: hint,
            text: text,
            validator: validator ?? (value) => value,
            keyboardtype: keyboardtype,
          ),
        ),
      ],
    );
  }
}
