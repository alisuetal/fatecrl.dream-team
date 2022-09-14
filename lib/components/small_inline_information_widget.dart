import 'package:flutter/material.dart';
import 'dart:math' as math;

class SmallInlineInformationWidget extends StatelessWidget {
  final String? iconText;
  final String leftText;
  final String rightText;

  const SmallInlineInformationWidget({
    Key? key,
    required this.leftText,
    required this.rightText,
    this.iconText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        color: const Color(0xff2F2F2F),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: iconText == null
                      ? Transform.rotate(
                          angle: math.pi / 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          iconText!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                ),
                Text(
                  leftText,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            Text(
              rightText,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
