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
    TeamController teamController = Provider.of<TeamController>(context);

    Future<void> clearTeam(int value) async {
      userController.changeTatic(userController.user.email!, value);
      teamController.clearPlayers(userController.user.email!);
      userController.upDateLeonita(
          (userController.user.leonita! + teamController.teamValue()));
    }

    Future<void> removePlayer(int index) async {
      teamController.removePlayer(
          userController.user.email!, teamController.getId(index), index);
      userController.upDateLeonita(
          (userController.user.leonita! + teamController.getPrice(index)));
    }

    return ScreenHolderWidget(
      content: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/svg/background.svg",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
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
                          "T??tica:",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: const Color(0xffAAAAAA),
                                  ),
                        ),
                        MinimalDropDownWidget(
                          value: taticId,
                          items: const {
                            0: '3 Alas, 1 Armador e 1 Piv??',
                            1: '2 Alas, 2 Armadores e 1 Piv??',
                            2: '2 Alas, 1 Armador e 2 Piv??s',
                            3: '1 Ala, 3 Armadores e 1 Piv??',
                            4: '1 Ala, 2 Armadores e 2 Piv??s',
                            5: '1 Ala, 1 Armador e 3 Piv??s'
                          },
                          anchor: (int value) {
                            clearTeam(value).then((_) {
                              setState(() {
                                teamController.setTatic(value);
                                taticId = value;
                              });
                            });
                          },
                        )
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
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
                                    icon: Icons.remove,
                                    function: () => removePlayer(index)
                                        .then((_) => setState(() {})),
                                  ),
                                  price: teamController.getPrice(index),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: PlayerPositionCardWidget(
                                  position: teamController.getPosition(index),
                                  onTap: () {
                                    playerController
                                        .preLoad(
                                            teamController.getPosition(index),
                                            teamController.getPlayersId())
                                        .then((_) {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.playerMarket,
                                        arguments: [
                                          teamController.getPosition(index),
                                          index,
                                        ],
                                      ).then((_) => setState(() {}));
                                    });
                                  },
                                ),
                              );
                      },
                    ),
                    const SizedBox(
                      height: 160,
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
