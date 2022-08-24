import 'package:dream_team/tools/color_utilities.dart';
import 'package:flutter/material.dart';

class GhostButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color color;

  const GhostButtonWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: ColorUtilities.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: color,
                      fontFamily: "Coolvetica",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
