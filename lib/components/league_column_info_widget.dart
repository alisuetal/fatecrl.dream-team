import 'package:flutter/material.dart';

class LeagueColumnInfoWidget extends StatelessWidget {
  final String info;
  final String label;

  const LeagueColumnInfoWidget({
    required this.info,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Text(
              info,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 3,
                top: 3,
              ),
              child: Text(
                info,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.white,
                    ),
              ),
            ),
          ],
        ),
        Text(label),
      ],
    );
  }
}
