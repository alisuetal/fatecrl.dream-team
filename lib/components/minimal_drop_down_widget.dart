import 'package:flutter/material.dart';

class MinimalDropDownWidget extends StatefulWidget {
  final Map<int, String> items;
  final int value;
  final void Function(int value) anchor;

  const MinimalDropDownWidget({
    Key? key,
    required this.value,
    required this.items,
    required this.anchor,
  }) : super(key: key);

  @override
  State<MinimalDropDownWidget> createState() => _MinimalDropDownWidgetState();
}

class _MinimalDropDownWidgetState extends State<MinimalDropDownWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: widget.value,
      focusColor: Colors.white.withOpacity(0),
      icon: Padding(
        padding: const EdgeInsets.only(
          right: 8,
        ),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      dropdownColor: const Color(0xff2F2F2F),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
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
    );
  }
}
