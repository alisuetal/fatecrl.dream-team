import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  final String? text;
  final String hint;
  final Function(String value)? validator;
  final Function(String value)? onChange;
  final TextEditingController? controller;
  final TextInputType? keyboardtype;
  final bool? obscure;

  const TextfieldWidget({
    Key? key,
    this.text,
    required this.hint,
    this.controller,
    this.obscure,
    this.validator,
    this.keyboardtype,
    this.onChange,
  }) : super(key: key);

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.text ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: 64,
        child: Stack(
          children: [
            TextFormField(
              maxLength: 120,
              onChanged: (value) =>
                  widget.onChange != null ? widget.onChange!(value) : null,
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: const Color(0xff2F2F2F),
                counterText: "",
                contentPadding: const EdgeInsets.only(
                  top: 24,
                  left: 24,
                  bottom: 18,
                  right: 48,
                ),
                hintText: widget.hint,
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
              cursorColor: Colors.white,
              obscureText: widget.obscure ?? false,
              validator: (value) => widget.validator!(value ?? ''),
              keyboardType: widget.keyboardtype,
            ),
            if (_textController.text != "" && _textController.text.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            _textController.text = "";
                          }),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white.withOpacity(0.08),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
