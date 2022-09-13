import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/header_profile_picture_widget.dart';
import 'package:dream_team/components/minimal_drop_down_widget.dart';
import 'package:dream_team/components/player_position_card_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/controllers/team.dart';
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
  int taticId = 0;

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController =
        Provider.of<PlayerController>(context, listen: false);
    TeamController teamController =
        Provider.of<TeamController>(context, listen: false);

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
                      rightWidget: HeaderProfilePictureWidget(
                        imgSrc:
                            "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                        function: widget.changePage != null
                            ? () => widget.changePage!()
                            : () {},
                      ),
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
                            1: '2 Alas, 2 Armador e 1 Pivô',
                            2: '2 Alas, 1 Armador e 2 Pivôs',
                            3: '1 Alas, 3 Armador e 1 Pivô',
                            4: '1 Alas, 2 Armador e 2 Pivô',
                            5: '1 Alas, 1 Armador e 3 Pivô'
                          },
                          anchor: (int value) {
                            setState(() {
                              taticId = value;
                              teamController.setTatic(taticId);
                            });
                          },
                        )
                      ],
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemCount: teamController.taticSize(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: PlayerPositionCardWidget(
                            position: teamController.getPosition(index),
                            onTap: () {
                              playerController
                                  .loadPlayers(
                                      teamController.getPosition(index))
                                  .then((_) {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.playerMarket,
                                  arguments: teamController.getPosition(index),
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
