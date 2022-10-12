import 'package:dream_team/components/league_column_info_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:flutter/material.dart';

class LeagueInfoWidget extends StatelessWidget {
  final String name;
  final String creator;
  final int? position;
  final double? points;
  final void Function() onTap;
  final int? players;

  const LeagueInfoWidget({
    Key? key,
    required this.name,
    required this.creator,
    this.position,
    this.points,
    required this.onTap,
    this.players,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 112,
        color: const Color(0xff2F2F2F),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    creator,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              if (players == null)
                position != -1
                    ? LeagueColumnInfoWidget(
                        info: position!.toString(),
                        label: "Pos.",
                      )
                    : const LeagueColumnInfoWidget(
                        info: "",
                        label: "",
                      ),
              if (players == null)
                points != -1
                    ? LeagueColumnInfoWidget(
                        info: points!.toString(),
                        label: "Pts.",
                      )
                    : const LeagueColumnInfoWidget(
                        info: "",
                        label: "",
                      ),
              if (players != null)
                LeagueColumnInfoWidget(
                  info: players!.toString(),
                  label: "Partic.",
                ),
              RoundIconWidget(
                icon: Icons.arrow_forward_ios_rounded,
                function: () => onTap(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
