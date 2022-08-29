import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/round_icon_widget.dart';

class PlayerMarketScreen extends StatelessWidget {
  const PlayerMarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final position = ModalRoute.of(context)?.settings.arguments as String;
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
                      title: "Mercado",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Posição: ",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Color(0xffAAAAAA),
                                  ),
                        ),
                        Text(
                          position,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextfieldWithLabelWidget(
                        text: null,
                        hint: "Pesquisar jogador",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: PlayerCardWidget(
                        imgSrc:
                            "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                        name: "Mockup",
                        team: "Mockup team",
                        variation: 0.3,
                        points: 9,
                        rightWidget: RoundIconWidget(
                          icon: Icons.add_rounded,
                          function: () {},
                        ),
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
