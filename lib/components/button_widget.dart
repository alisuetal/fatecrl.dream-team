import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final IconData? materialIcon;
  final void Function() function;
  final bool enabled;

  const ButtonWidget({
    Key? key,
    required this.text,
    this.materialIcon,
    required this.function,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? function : () {},
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: enabled
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: materialIcon != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  text,
                  style: enabled
                      ? Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          )
                      : Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white.withOpacity(0.4)),
                ),
              ),
              if (materialIcon != null)
                Icon(
                  materialIcon,
                  size: 28,
                  color: enabled ? Colors.white : Colors.white.withOpacity(0.4),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
