import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/header_profile_picture_widget.dart';
import 'package:dream_team/components/minimal_drop_down_widget.dart';
import 'package:dream_team/components/player_position_card_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamScreen extends StatelessWidget {
  final void Function()? changePage;
  const TeamScreen({
    this.changePage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenHolderWidget(
      content: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            fit: BoxFit.cover,
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
                        function:
                            changePage != null ? () => changePage!() : () {},
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
                          value: 0,
                          items: const {0: "Tática"},
                          anchor: (_) {},
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: PlayerCardWidget(
                        imgSrc:
                            "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                        name: "Mockup",
                        team: "Mockup team",
                        variation: 0.3,
                        points: 9,
                        rightWidget: RoundIconWidget(
                          icon: Icons.remove_rounded,
                          function: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: PlayerPositionCardWidget(
                        position: "Ala",
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.playerMarket,
                            arguments: "Ala",
                          );
                        },
                      ),
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
