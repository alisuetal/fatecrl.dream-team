import 'package:flutter/material.dart';

class DropDownWithLabelWidget extends StatefulWidget {
  final Map<int, String> items;
  final int value;
  final String hint;
  final void Function(int value) anchor;

  const DropDownWithLabelWidget({
    Key? key,
    required this.value,
    required this.items,
    required this.anchor,
    required this.hint,
  }) : super(key: key);

  @override
  State<DropDownWithLabelWidget> createState() =>
      _DropDownWithLabelWidgetState();
}

class _DropDownWithLabelWidgetState extends State<DropDownWithLabelWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hint,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color(0xffAAAAAA), fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: SizedBox(
              height: 64,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color(0xff2F2F2F),
                ),
                child: Center(
                  child: DropdownButton<int>(
                    value: widget.value,
                    focusColor: Colors.white.withOpacity(0),
                    icon: const Padding(
                      padding: EdgeInsets.only(
                        right: 8,
                      ),
                      child: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                    dropdownColor: const Color(0xff2F2F2F),
                    isExpanded: true,
                    style: Theme.of(context).textTheme.bodyText1,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    underline: Container(),
                    onChanged: (int? newValue) {
                      widget.anchor(newValue!);
                    },
                    items: widget.items.entries.map<DropdownMenuItem<int>>(
                      (MapEntry<int, String> item) {
                        return DropdownMenuItem<int>(
                          value: item.key,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                            ),
                            child: Text(item.value),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
