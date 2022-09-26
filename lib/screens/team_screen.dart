import 'dart:math';

import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/header_profile_picture_widget.dart';
import 'package:dream_team/components/leonitas_market_widget.dart';
import 'package:dream_team/components/minimal_drop_down_widget.dart';
import 'package:dream_team/components/player_position_card_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/controllers/team.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/models/player.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controllers/player.dart';

class TeamScreen extends StatefulWidget {
  final void Function()? changePage;
  const TeamScreen({
    this.changePage,
    Key? key,
  }) : super(key: key);

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    int taticId = userController.user.tatic!;
    final PlayerController playerController =
        Provider.of<PlayerController>(context, listen: false);
    TeamController teamController =
        Provider.of<TeamController>(context, listen: false);

    print(teamController.getPlayers().length);

    return ScreenHolderWidget(
      content: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/svg/background.svg",
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      title: "Meu Time",
                      rightWidget: LeonitasMarketWidget(
                          leonitas: userController.user.leonita!),
                    ),
                    Row(
                      children: [
                        Text(
                          "Tática:",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: const Color(0xffAAAAAA),
                                  ),
                        ),
                        MinimalDropDownWidget(
                          value: taticId,
                          items: const {
                            0: '3 Alas, 1 Armador e 1 Pivô',
                            1: '2 Alas, 2 Armadores e 1 Pivô',
                            2: '2 Alas, 1 Armador e 2 Pivôs',
                            3: '1 Ala, 3 Armadores e 1 Pivô',
                            4: '1 Ala, 2 Armadores e 2 Pivôs',
                            5: '1 Ala, 1 Armador e 3 Pivôs'
                          },
                          anchor: (int value) {
                            userController
                                .changeTatic(userController.user.email!, value)
                                .then((_) {
                              teamController
                                  .clearPlayers(userController.user.email!)
                                  .then((_) {
                                setState(() {
                                  teamController.setTatic(value);
                                  taticId = value;
                                  print(taticId);
                                });
                              });
                            });
                          },
                        )
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return teamController.isPlayer(index)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: PlayerCardWidget(
                                  imgSrc: teamController.getImageUrl(index),
                                  name: teamController.getName(index),
                                  team: teamController.getTeam(index),
                                  variation: teamController.getVariation(index),
                                  points:
                                      teamController.getPoints(index).toInt(),
                                  rightWidget: RoundIconWidget(
                                    icon: Icons.add_rounded,
                                    function: () => {},
                                  ),
                                  price: teamController
                                      .getPrice(index), //TO-DO: ADD PRICE
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: PlayerPositionCardWidget(
                                  position: teamController.getPosition(index),
                                  onTap: () {
                                    playerController
                                        .loadPlayers(
                                            teamController.getPosition(index))
                                        .then((_) {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.playerMarket,
                                        arguments: [
                                          teamController.getPosition(index),
                                          index,
                                        ],
                                      );
                                    });
                                  },
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
