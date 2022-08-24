import 'package:dream_team/components/round_icon_widget.dart';
import 'package:flutter/material.dart';

class PlayerPositionCardWidget extends StatelessWidget {
  final String position;
  final void Function() onTap;

  const PlayerPositionCardWidget({
    Key? key,
    required this.position,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xff2F2F2F),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              position,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            RoundIconWidget(
              icon: Icons.add_rounded,
              function: () => onTap(),
            )
          ],
        ),
      ),
    );
  }
}
