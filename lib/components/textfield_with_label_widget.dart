import 'package:flutter/material.dart';

import 'textfield_widget.dart';

class TextfieldWithLabelWidget extends StatelessWidget {
  final String hint;
  final Function(String text)? validator;
  final TextInputType? keyboardtype;
  final TextEditingController? controller;
  final String? text;
  final bool? obscure;

  const TextfieldWithLabelWidget(
      {Key? key,
      this.text,
      required this.hint,
      this.controller,
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
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: const Color(0xffAAAAAA)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextfieldWidget(
            hint: hint,
            text: text,
            validator: validator ?? (value) => value,
            keyboardtype: keyboardtype,
            controller: controller,
            obscure: obscure,
          ),
        ),
      ],
    );
  }
}
